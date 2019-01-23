# frozen_string_literal: true

def apache_user(node)
  if node['platform_family'] == 'debian'
    user = 'www-data'
  elsif node['platform_family'] == 'rhel'
    user = 'apache'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return user
end

def django_user
  return 'django'
end

def django_group
  return 'django'
end

def apache_home_dir(node)
  if node['platform_family'] == 'debian'
    dir = '/var/www'
  elsif node['platform_family'] == 'rhel'
    dir = '/usr/share/httpd'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return dir
end

def apache_shell(node)
  if node['platform_family'] == 'debian'
    shell = '/usr/sbin/nologin'
  elsif node['platform_family'] == 'rhel'
    shell = '/sbin/nologin'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return shell
end

def path_to_base_conf_dir(node)
  return '/etc/apache2' if node['platform_family'] == 'debian'

  return '/etc/httpd'
end

def path_to_conf_directory(node)
  return File.join(path_to_base_conf_dir(node), 'conf-available')
end

def path_to_host_directory(node)
  return File.join(path_to_base_conf_dir(node), 'conf.d')
end

def path_to_http_host(node)
  return File.join(path_to_host_directory(node), 'ssl-host.conf')
end

def path_to_django_conf(node)
  return File.join(path_to_conf_directory(node), 'django.conf')
end

def path_to_django_conf_link(node)
  return File.join(path_to_base_conf_dir(node), 'conf-enabled/django.conf')
end

def path_to_django_host(node)
  return File.join(path_to_host_directory(node), 'django-host.conf')
end

def path_to_vhost(node)
  return File.join(path_to_base_conf_dir(node), 'sites-available/ssl-site.conf')
end

def apache_dev_package_name(node)
  return 'apache2-dev' if node['platform_family'] == 'debian'

  return 'httpd-devel'
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

def python_version(node)
  return '3.5' if node['platform_family'] == 'debian' && node['platform_version'] == '16.04'

  return '3.6'
end

def python_package(node)
  if node['platform_family'] == 'debian'
    package = 'python3'
  elsif node['platform_family'] == 'rhel'
    package = 'python36'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return package
end

def python_package_prefix(node)
  if node['platform_family'] == 'debian'
    package = 'python3-'
  elsif node['platform_family'] == 'rhel'
    package = 'python36-'
  else
    raise "Platform family not recognized: #{node['platform_family']}"
  end
  return package
end

def path_to_venv
  return '/home/django/env'
end

def path_to_pip
  return File.join(path_to_venv, 'bin/pip')
end
