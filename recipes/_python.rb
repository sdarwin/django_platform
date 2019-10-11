# frozen_string_literal: true

tcb = 'django_platform'

include_recipe "#{tcb}::_python_source" if source_install?
include_recipe "#{tcb}::_python_package" unless source_install?

# poise-python is busted:
# Python package detection does not work on Ubuntu or CentOS
# Virtual environment creation is broken in CentOS
# Pip install is broken as of Pip 19
# We use it only to manage packages
bash 'Django Environment' do
  code "#{path_to_system_python} -m venv #{path_to_python_env}"
  not_if { File.exist?("#{path_to_python_env}/bin/activate") }
end

packages = node[tcb]['python']['packages_to_install']
packages.each do |package, version|
  code = "#{path_to_django_pip_binary} install #{package}"
  code += "==#{version}" unless version.nil? || version.empty?
  match = "#{path_to_django_pip_binary} list | grep #{package}"
  match += " | grep #{version}" unless version.nil? || version.empty?
  bash "Python Package #{package}" do
    code code
    not_if match
    notifies :restart, 'service[apache2]', :delayed
  end
end

if node[tcb]['python']['packages_to_install'].include?('mod_wsgi')
  bash 'Install WSGI' do
    code "#{path_to_wsgi_installer} install-module"
    # not_if "[ -f #{File.join(path_to_apache_mod_libs, module_name)} ]"
    not_if 'apachectl -M | grep -q wsgi'
    notifies :restart, 'service[apache2]', :delayed
  end

  apache2_module 'wsgi' do
    mod_name wsgi_module_name
  end
end
