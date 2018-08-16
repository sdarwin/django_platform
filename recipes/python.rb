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

directory '/home/django' do
  owner 'django'
  group 'django'
  mode '0755'
  recursive true
end

python_virtualenv '/home/django/env' do
  user 'django'
  group 'django'
  python '3'
end

include_recipe 'git::default'

# Will raise 404 error if not found
ssh_secret = chef_vault_item(node[tcb]['git_ssh_key']['vault_data_bag'],
                             node[tcb]['git_ssh_key']['vault_bag_item'])
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

git '/home/django/app' do
  user 'django'
  group 'django'
  repository node[tcb]['app_repo']['repository']
  # enable_checkout false # use checkout_branch
  revision node[tcb]['app_repo']['revision']
  enable_submodules true
  environment node[tcb]['app_repo']['environment']
  notifies :restart, "service[#{node[tcb]['apache']['service_name']}]", :delayed
end
