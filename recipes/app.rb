# frozen_string_literal: true

tcb = 'django_platform'

app_repo = node[tcb]['app_repo']
repo_url = "git@#{app_repo['git_host']}:#{app_repo['git_user']}/#{app_repo['git_repo']}"

ssh_known_hosts_entry app_repo['git_host'] do
  host app_repo['git_host']
  file_location '/home/django/.ssh/known_hosts'
  owner 'django'
  group 'django'
end

file 'First-Run Django Sentinel' do
  path '/opt/chef/run_record/django_sentinel.txt'
  content 'This is a sentinel to detect the first run of django_platform'
  mode '0644'
  # Write the entry to disk so the checkout succeeds the first time!
  notifies :flush, "ssh_known_hosts_entry[#{app_repo['git_host']}]", :immediate
end

git path_to_app_repo do
  user 'django'
  group 'django'
  repository repo_url
  # enable_checkout false # use checkout_branch
  revision app_repo['git_revision']
  enable_submodules true
  environment app_repo['environment']
  notifies :restart, "service[#{apache_service}]", :delayed
end

unless node[tcb]['app_repo']['rel_path_to_pip_requirements'].nil?
  pip_requirements 'Application requirements' do
    path File.join(path_to_app_repo, node[tcb]['app_repo']['rel_path_to_pip_requirements'])
    user 'django'
    group 'django'
    virtualenv path_to_venv
  end
end

python_execute 'Migrate App Data' do
  command manage_command('migrate')
  cwd path_to_app_repo
  virtualenv path_to_venv
  user 'django'
  group 'django'
  action :nothing
  subscribes :run, "git[#{path_to_app_repo}]", :delayed # Must be after pip requirements
end

python_execute 'Collect Static' do
  command manage_command('collectstatic --noinput')
  cwd path_to_app_repo
  virtualenv path_to_venv
  user 'django'
  group 'django'
  action :nothing
  subscribes :run, "git[#{path_to_app_repo}]", :delayed
  only_if { File.open(path_to_settings_py).read =~ /STATIC_ROOT/ }
end

node[tcb]['app_repo']['additional_management_commands'].each do |code|
  cmd = manage_command(code)
  python_execute "Manage Command: #{cmd}" do
    command cmd
    cwd path_to_app_repo
    virtualenv path_to_venv
    user 'django'
    group 'django'
    action :nothing
    subscribes :run, "git[#{path_to_app_repo}]", :delayed
  end
end

node[tcb]['app_repo']['additional_shell_scripts'].each do |script|
  bash "Shell Script: #{script}" do
    code script
    cwd path_to_app_repo
    user 'django'
    group 'django'
    action :nothing
    subscribes :run, "git[#{path_to_app_repo}]", :delayed
  end
end

var_map = {
  path_to_http_root: File.join(path_to_app_repo, rel_path_to_http_root),
  path_to_static_directory: File.join(path_to_app_repo, rel_path_to_static_directory),
  path_to_venv: path_to_venv,
  path_to_wsgi_py: File.join(path_to_app_repo, rel_path_to_site_directory, 'wsgi.py'),
  rel_path_to_site_directory: rel_path_to_site_directory,
  rel_path_to_static_directory: rel_path_to_static_directory
}

django_conf = File.join(conf_available_directory, 'django.conf')

# We use template because apache_conf does not support variables
template 'Django Conf' do
  path django_conf
  source 'django.conf.erb'
  variables var_map
  owner 'root'
  group 'root'
  mode '0440'
  notifies :restart, "service[#{apache_service}]", :delayed
end

link 'Link for Django Conf' do
  target_file File.join(conf_enabled_directory, 'django.conf')
  to django_conf
  owner 'root'
  group 'root'
  notifies :restart, "service[#{apache_service}]", :delayed
end

template 'Django Host' do
  path File.join(config_absolute_directory, 'django-host.conf')
  source 'django-host.conf.erb'
  variables var_map
  owner 'root'
  group 'root'
  mode '0440'
  notifies :restart, "service[#{apache_service}]", :delayed
end
