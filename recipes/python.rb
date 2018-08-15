# frozen_string_literal: true

tcb = 'se_django_app'

# '3' works in CentOS 7 but not Ubuntu 18 as of August 2018
if platform_family?('debian')
  python_runtime '3' do
    options package_name: 'python3'
  end
else
  python_runtime '3'
end

directory '/opt/django_app' do
  owner 'django'
  group 'django'
  mode '0755'
  recursive true
end

python_virtualenv '/opt/django_app/env' do
  user 'django'
  group 'django'
  python '3'
end

include_recipe 'git::default'
