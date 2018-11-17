# frozen_string_literal: true

tcb = 'django_platform'

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
  mode '0750'
  recursive true
end

# Will raise 404 error if not found
ssh_secret = chef_vault_item(
  node[tcb]['git_ssh_key']['vault_data_bag'],
  node[tcb]['git_ssh_key']['vault_bag_item']
)
raise 'Unable to retrieve data bag for SSH key' if ssh_secret.nil?

ssh_key = ssh_secret[node[tcb]['git_ssh_key']['vault_item_key']]
raise 'Unable to retrieve SSH key' if ssh_key.nil?

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
  content ssh_key
end
