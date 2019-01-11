# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe package(postgresql_package(node)) do
  it { should be_installed }
  its(:version) { should match '^10' }
end

describe service(postgresql_service(node)) do
  it { should be_installed }
  # it { should be_enabled } # TODO: CentOS broken
  # it { should be_running } # TODO: CentOS broken
end

# TODO: Tests once we implement PostgreSQL
