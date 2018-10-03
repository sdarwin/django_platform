# frozen_string_literal: true

tcb = 'django_platform'

# We want to run django 2.1
# Django 2.1 requires python 3.5 and CentOS 7 ships with 3.3, so we must install non-standard python

include_recipe 'yum-epel::default'
include_recipe 'yum-ius::default' # Needed for Python 3.6

python_runtime '3' do
  options package_name: python_package_name
end

python_virtualenv '/home/django/env' do
  user 'django'
  group 'django'
  python '3'
end

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

git '/home/django/repo' do
  user 'django'
  group 'django'
  repository repo_url
  # enable_checkout false # use checkout_branch
  revision app_repo['git_revision']
  enable_submodules true
  environment app_repo['environment']
  notifies :restart, "service[#{apache_service}]", :delayed
end
