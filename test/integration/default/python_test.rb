# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe package(python_package(node)) do
  it { should be_installed }
  its(:version) { should match '^3.6' }
end
