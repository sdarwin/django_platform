# frozen_string_literal: true

tcb = 'django_platform'

# We want to run django 2.1
# Django 2.1 requires python 3.5 and CentOS 7 ships with 3.3, so we must install non-standard python

include_recipe 'yum-epel::default'

# poise-python is busted:
# Package detection does not work on Ubuntu or CentOS
# Virtual environment creation is broken in CentOS
# We use it only to manage packages
package python_package_name
package "#{python_package_prefix}venv" do
  only_if { node['platform_family'] == 'debian' }
end

bash 'Virtual Environment for Django' do
  code "#{python_command} -m venv /home/django/env"
  user 'django'
  group 'django'
  not_if { File.exist?(File.join(path_to_venv, 'bin/activate')) }
end

node[tcb]['python']['packages_to_install'].each do |package, version|
  python_package package do
    python File.join(path_to_venv, 'bin/python')
    user 'django'
    group 'django'
    version version if version
  end
end
