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

def postgresql_package(node)
  if node['platform_family'] == 'debian'
    package = 'postgresql-10'
  elsif node['platform_family'] == 'rhel'
    package = 'postgresql10-server'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return package
end

def postgresql_service(node)
  if node['platform_family'] == 'debian'
    service = 'postgresql'
  elsif node['platform_family'] == 'rhel'
    service = 'postgresql-10'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return service
end

def python_package(node)
  if node['platform_family'] == 'debian'
    package = 'python3'
  elsif node['platform_family'] == 'rhel'
    package = 'python36u'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return package
end

def busted_poise?
  return true
end
