# frozen_string_literal: true

tcb = 'django_platform'

user 'django' do
  system node[tcb]['django_is_system_user']
  shell '/usr/sbin/nologin' if node[tcb]['django_is_system_user']
  shell '/bin/bash' unless node[tcb]['django_is_system_user']
  manage_home false # Works on Ubuntu but CentOS does not grant group access
end

group 'django' do
  members ['django', apache_user]
end

directory '/home/django' do
  owner 'django'
  group 'django'
  mode '0750'
  recursive true
end

bag = node[tcb]['git_ssh_key']['vault_data_bag']
item = node[tcb]['git_ssh_key']['vault_bag_item']
key = node[tcb]['git_ssh_key']['vault_item_key']

# We need credentials to check out a repo owned by django
directory '/home/django/.ssh' do
  owner 'django'
  group 'django'
  mode '0700'
  recursive true
end

file '/home/django/.ssh/id_rsa' do
  owner 'django'
  group 'django'
  mode '0700'
  sensitive true
  content vault_secret(bag, item, key)
end
