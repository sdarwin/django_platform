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
