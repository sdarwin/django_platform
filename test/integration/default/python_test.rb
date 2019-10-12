# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe pip('pip', path_to_pip) do
  it { should be_installed }
end

describe pip('wheel', path_to_pip) do
  it { should be_installed }
end

describe pip('setuptools', path_to_pip) do
  it { should be_installed }
end

describe pip(wsgi_package_name(node), path_to_pip) do
  it { should be_installed }
  its('version') { should match(/^4\./) }
end

apache_lib_dir =
  if node['platform_family'] == 'debian'
    '/usr/lib/apache2/modules'
  else
    '/usr/lib64/httpd/modules'
  end

describe bash("ls #{apache_lib_dir}") do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match 'mod_wsgi' }
end

describe bash('apachectl -M') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match 'wsgi_module' }
end
