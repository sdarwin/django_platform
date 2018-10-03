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

git '/home/django/app' do
  user 'django'
  group 'django'
  repository node[tcb]['app_repo']['repository']
  # enable_checkout false # use checkout_branch
  revision node[tcb]['app_repo']['revision']
  enable_submodules true
  environment node[tcb]['app_repo']['environment']
  notifies :restart, "service[#{apache_service}]", :delayed
end
