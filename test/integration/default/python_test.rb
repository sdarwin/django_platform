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

describe file('/home/django/env/pyvenv.cfg') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end
