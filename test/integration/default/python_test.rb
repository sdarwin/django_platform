# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe package(python_package(node)) do
  it { should be_installed }
  its(:version) { should match '^3.6' }
end

if node['platform_family'] == 'debian'
  describe package(python_package_prefix(node) + 'venv') do
    it { should be_installed }
  end
end

describe file(File.join(path_to_venv, 'bin/activate')) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end

describe pip('pip', path_to_pip) do
  it { should be_installed }
  # its('version') { should match(/^18\./) }
end

describe pip('wheel', path_to_pip) do
  it { should be_installed }
  its('version') { should match(/^0\.32\./) }
end

describe pip('setuptools', path_to_pip) do
  it { should be_installed }
  its('version') { should match(/^39\.0/) }
end

describe pip('Django', path_to_pip) do
  it { should be_installed }
  its('version') { should match(/^2\.1/) }
end
