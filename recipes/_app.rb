# frozen_string_literal: true

tcb = 'django_platform'

node[tcb]['app_repo']['additional_access_directories'].each do |dir, options|
  directory dir do
    owner 'django'
    group 'django'
    mode '775' unless options.is_a?(Hash) && options['mode']
    mode options['mode'] if options.is_a?(Hash) && options['mode']
    recursive false unless options.is_a?(Hash) && options['recursive']
    recursive options['recursive'] if options.is_a?(Hash) && options['recursive']
  end
end

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
    action :nothing
    subscribes :install, "git[#{path_to_app_repo}]", :immediate # Must be before migrations
  end
end

python_execute 'Migrate App Data' do
  command manage_command('migrate')
  cwd path_to_app_repo
  virtualenv path_to_venv
  user 'django'
  group 'django'
  action :nothing
  subscribes :run, "git[#{path_to_app_repo}]", :immediate # Must be after pip requirements
end

python_execute 'Collect Static' do
  command manage_command('collectstatic --noinput')
  cwd path_to_app_repo
  virtualenv path_to_venv
  user 'django'
  group 'django'
  action :nothing
  subscribes :run, "git[#{path_to_app_repo}]", :immediate
  only_if { File.open(path_to_settings_py).read =~ /\n\s*STATIC_ROOT/ }
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
    subscribes :run, "git[#{path_to_app_repo}]", :immediate
  end
end

node[tcb]['app_repo']['additional_shell_scripts'].each do |script|
  code = "source #{path_to_venv_activate}\n. #{script}"
  bash "Shell Script: #{script}" do
    code code
    cwd path_to_app_repo
    user 'django'
    group 'django'
    action :nothing
    subscribes :run, "git[#{path_to_app_repo}]", :immediate
  end
end

if node[tcb]['app_repo']['rel_path_to_sqlite_db']
  # Django group must have write permissions in the directory and on the file
  directory path_to_app_repo do
    user 'django'
    group 'django'
    mode '0770'
  end
  file path_to_sqlite_db do
    user 'django'
    group 'django'
    mode '0660'
  end
end
