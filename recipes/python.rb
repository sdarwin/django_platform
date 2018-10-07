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

