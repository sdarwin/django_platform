# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe bash('yum repolist') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match 'epel/x86_64' }
  before do
    skip if node['platform_family'] == 'debian'
  end
end

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
end

describe pip('wheel', path_to_pip) do
  it { should be_installed }
end

describe pip('setuptools', path_to_pip) do
  it { should be_installed }
end

describe pip('Django', path_to_pip) do
  it { should be_installed }
  its('version') { should match(/^2\.1/) }
end
