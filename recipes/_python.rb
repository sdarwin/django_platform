# frozen_string_literal: true

tcb = 'django_platform'

package python_package_name
package "#{python_package_prefix}venv" do
  only_if { node['platform_family'] == 'debian' }
end

# We may need to build some wheels from source
package 'gcc'
package python_dev_package_name

python_virtualenv path_to_venv do
  python path_to_system_python
  pip_version true
  setuptools_version true
  wheel_version true
  user django_user
  group django_group
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
code = "#{File.join(path_to_venv, 'bin/python')} -m pip.__main__ install mod_wsgi#{wsgi_version}"
bash 'Compile WSGI' do
  code code
  only_if { install_wsgi }
  not_if 'apachectl -M | grep wsgi'
  notifies :restart, "service[apache2]", :delayed
end

node[tcb]['python']['packages_to_install'].each do |package, version|
  python_package package do
    version version if version
    user django_user
    group django_group
    python path_to_python_binary
  end
end

module_name =
  if node['platform_family'] == 'debian' && node['platform_version'] == '16.04'
    'mod_wsgi-py35.cpython-35m-x86_64-linux-gnu.so'
  else
    'mod_wsgi-py36.cpython-36m-x86_64-linux-gnu.so'
  end

if node[tcb]['python']['packages_to_install'].include?('mod_wsgi')
  bash 'Install WSGI' do
    code "#{path_to_wsgi_installer} install-module"
    not_if "[ -f #{File.join(path_to_apache_mod_libs, module_name)} ]"
    notifies :restart, "service[apache2]", :delayed
  end

  apache2_module 'wsgi' do
    #filename module_name
    mod_name module_name
  end
end
