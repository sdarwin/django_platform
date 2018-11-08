# frozen_string_literal: true

tcb = 'django_platform'

app_repo = node[tcb]['app_repo']
repo_url = "git@#{app_repo['git_host']}:#{app_repo['git_user']}/#{app_repo['git_repo']}"

# This fails the first time because of a message saying the host was added (non-interactive) then succeeds

ssh_known_hosts_entry app_repo['git_host'] do
  host app_repo['git_host']
  file_location '/home/django/.ssh/known_hosts'
  owner 'django'
  group 'django'
  action [:create, :flush] # Write the entry to disk so the checkout succeeds the first time!
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

bash 'Update App Data' do
  code <<-SCRIPT
    source #{path_to_venv}/bin/activate
    #{path_to_manage_py} migrate
    #{path_to_manage_py} collectstatic --noinput
  SCRIPT
  user 'django'
  group 'django'
  action :nothing
  subscribes :run, "git[#{path_to_app_repo}]", :immediate
end
