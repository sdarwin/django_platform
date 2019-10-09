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
  build_shared true # Better for mod_wsgi compilation
end

packages = node[tcb]['python']['packages_to_install']
packages.each do |package, version|
  code = "#{path_to_django_pip_binary} install #{package}"
  code += "==#{version}" unless version.empty?
  match = "#{path_to_django_pip_binary} list | grep #{package}"
  match += " | grep #{version}" unless version.empty?
  bash "Python Package #{package}" do
    code code
    not_if match
    notifies :restart, 'service[apache2]', :delayed
  end
end

python_rev = django_python_revision
module_name = "mod_wsgi-py#{python_rev}.cpython-#{python_rev}m-x86_64-linux-gnu.so"

if node[tcb]['python']['packages_to_install'].include?('mod_wsgi')
  bash 'Install WSGI' do
    code "#{path_to_wsgi_installer} install-module"
    # not_if "[ -f #{File.join(path_to_apache_mod_libs, module_name)} ]"
    not_if 'apachectl -M | grep -q wsgi'
    notifies :restart, 'service[apache2]', :delayed
  end

  apache2_module 'wsgi' do
    mod_name module_name
  end
end
