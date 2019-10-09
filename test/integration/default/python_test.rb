# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe package('gcc') do
  it { should be_installed }
end

describe file(path_to_openssl) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file(path_to_sqlite) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file(path_to_python) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe pip('pip', path_to_pip) do
  it { should be_installed }
end

describe pip('wheel', path_to_pip) do
  it { should be_installed }
end

describe pip('setuptools', path_to_pip) do
  it { should be_installed }
end

describe pip('mod_wsgi', path_to_pip) do
  it { should be_installed }
  its('version') { should match(/^4\./) }
end

describe pip('Django', path_to_pip) do
  it { should be_installed }
  its('version') { should match(/^2\.2/) }
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
