# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe package(python_package(node)) do
  it { should be_installed }
  its(:version) { should match '^3.6' }
end

if busted_poise?
  describe package(python_package(node) + '-pip') do
    it { should be_installed }
    its(:version) { should match '^3.6' }
  end
  describe package(python_package(node) + '-setuptools') do
    it { should be_installed }
    its(:version) { should match '^3.6' }
  end
  describe package(python_package(node) + '-wheel') do
    it { should be_installed }
    its(:version) { should match '^3.6' }
  end
else
  describe file('/home/django/env/pyvenv.cfg') do
    it { should exist }
    it { should be_file }
    it { should be_mode 0o644 }
    it { should be_owned_by 'django' }
    it { should be_grouped_into 'django' }
  end
end
