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

update_script = <<~SCRIPT
  '''#{path_to_manage_py} migrate
  #{path_to_manage_py} collectstatic --noinput'''
SCRIPT

python_execute 'Update App Data' do
  command update_script
  virtualenv path_to_venv
  user 'django'
  group 'django'
  action :nothing
  subscribes :run, "git[#{path_to_app_repo}]", :immediate
end
