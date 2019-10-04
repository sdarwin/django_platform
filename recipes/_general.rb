
#disable selinux
if platform_family?('rhel')
  selinux_state "SELinux #{node['selinux']['state'].capitalize}" do
    action node['selinux']['state'].downcase.to_sym
  end
end

