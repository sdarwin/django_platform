# frozen_string_literal: true

tcb = 'django_platform'

include_recipe 'openssl_install::default'
include_recipe 'sqlite_install::default'
include_recipe 'python_install::default'

openssl_installation 'OpenSSL Install' do
  version node[tcb]['openssl']['version_to_install'] if node[tcb]['openssl']['version_to_install']
end

sqlite_installation 'SQLite Install' do
  version node[tcb]['sqlite']['version_to_install'] if node[tcb]['sqlite']['version_to_install']
end

python_installation 'Python Install' do
  version node[tcb]['python']['version_to_install'] if node[tcb]['python']['version_to_install']
  openssl_directory default_openssl_directory
  sqlite_directory default_sqlite_directory
end

# This is a kludge because wsgi fails to build on CentOS
# However, running the same command succeeds?!
packages = node[tcb]['python']['packages_to_install']
install_wsgi = !packages['mod_wsgi'].nil?
wsgi_version =
  if install_wsgi && !packages['mod_wsgi'].empty?
    "==#{packages['mod_wsgi']}"
  else
    ''
  end
code = "#{path_to_django_python_binary} -m pip.__main__ install mod_wsgi#{wsgi_version}"
bash 'Compile WSGI' do
  code code
  only_if { install_wsgi }
  not_if 'apachectl -M | grep wsgi'
  notifies :restart, 'service[apache2]', :delayed
end

node[tcb]['python']['packages_to_install'].each do |package, version|
  python_package package do
    version version if version
    user django_user
    group django_group
    python path_to_django_python_binary
  end
end

python_revision = python_revision
module_name = "mod_wsgi-py#{python_revision}.cpython-#{python_revision}m-x86_64-linux-gnu.so"

if node[tcb]['python']['packages_to_install'].include?('mod_wsgi')
  bash 'Install WSGI' do
    code "#{path_to_wsgi_installer} install-module"
    not_if "[ -f #{File.join(path_to_apache_mod_libs, module_name)} ]"
    notifies :restart, 'service[apache2]', :delayed
  end

  apache2_module 'wsgi' do
    mod_name module_name
  end
end
