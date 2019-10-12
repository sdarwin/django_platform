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

def apache_service(node)
  return 'apache2' if node['platform_family'] == 'debian'

  return 'httpd'
end

def path_to_base_conf_dir(node)
  return '/etc/apache2' if node['platform_family'] == 'debian'

  return '/etc/httpd'
end

def path_to_conf_directory(node)
  return File.join(path_to_base_conf_dir(node), 'conf-available')
end

def path_to_host_directory(node)
  return File.join(path_to_base_conf_dir(node), 'conf-available')
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

def path_to_openssl
  return '/opt/openssl/1.1.1d/bin/openssl'
end

def path_to_sqlite
  return '/opt/sqlite/3300000/bin/sqlite3'
end

def python_version(node)
  debian35 = node['platform_version'] == '16.04' || node['platform_version'] == '9'
  return '3.5' if node['platform_family'] == 'debian' && debian35

  return '3.6'
end

def python_package(_node)
  return 'python3'
end

def python_package_prefix(_node)
  return 'python3-'
end

def python_dev_package(node)
  return 'python3-dev' if node['platform_family'] == 'debian'

  return 'python3-devel'
end

def path_to_python_env
  return '/home/django/env'
end

def path_to_python
  return File.join(path_to_python_env, 'bin/python')
end

def path_to_pip
  return File.join(path_to_python_env, 'bin/pip')
end

def wsgi_package_name(node)
  return 'mod-wsgi' if node['platform'] == 'ubuntu'

  return 'mod_wsgi'
end

def django_version(node)
  return '2.2' if node['platform_family'] == 'debian' || python_version(node).to_f > 3.6

  return '2.1'
end
