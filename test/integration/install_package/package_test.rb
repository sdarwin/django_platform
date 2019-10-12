# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe bash('yum repolist') do
  its(:exit_status) { should eq 0 }
  # bento box has wonky locale
  its(:stderr) { should eq '' } unless node['platform'] == 'centos' && node['platform_version'].to_f < 8.0
  its(:stdout) { should match 'epel/x86_64' }
  before do
    skip if node['platform_family'] == 'debian'
  end
end

describe package(python_package(node)) do
  it { should be_installed }
  its(:version) { should match python_version(node) }
end

describe package(python_package_prefix(node) + 'venv') do
  it { should be_installed }
  before do
    skip if node['platform_family'] != 'debian'
  end
end

describe package('gcc') do
  it { should be_installed }
end

describe package(python_dev_package(node)) do
  it { should be_installed }
  its(:version) { should match python_version(node) }
end

describe pip('Django', path_to_pip) do
  it { should be_installed }
  its('version') { should match(django_version(node)) }
end
