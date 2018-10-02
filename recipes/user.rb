# frozen_string_literal: true

user 'django' do
  system true
  shell '/usr/sbin/nologin'
  manage_home false # Works on Ubuntu but CentOS does not grant group access
end

group 'django' do
  members ['django', apache_user]
end

directory '/home/django' do
  owner 'django'
  group 'django'
  mode '0755'
  recursive true
end
