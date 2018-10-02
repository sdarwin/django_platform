# frozen_string_literal: true

def apache_user(node)
  if node['platform_family'] == 'debian'
    user = 'root'
  elsif node['platform_family'] == 'rhel'
    user = 'apache'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return user
end

def apache_home_dir(node)
  if node['platform_family'] == 'debian'
    dir = '/root'
  elsif node['platform_family'] == 'rhel'
    dir = '/usr/share/httpd'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return dir
end

def apache_shell(node)
  if node['platform_family'] == 'debian'
    shell = '/bin/bash'
  elsif node['platform_family'] == 'rhel'
    shell = '/sbin/nologin'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return shell
end
