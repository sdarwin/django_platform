# frozen_string_literal: true

# disable selinux
if platform_family?('rhel')
  selinux_state "SELinux #{node['selinux']['state'].capitalize}" do
    action node['selinux']['state'].downcase.to_sym
  end
end

idemp_file = '/var/chef/idempotence/django_first_run_update'

apt_update 'Pre-Install Update' do
  action :update
  not_if { File.exist?(idemp_file) }
end

directory '/var/chef/idempotence' do
  user 'root'
  group 'root'
  recursive true
end

file idemp_file do
  content 'Sentinel'
end
