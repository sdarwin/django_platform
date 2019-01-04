# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe file(path_to_http_host(node)) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  # its(:content) { should match('DocumentRoot /home/django/repo/app') }
end

describe package(apache_dev_package_name(node)) do
  it { should be_installed }
  its(:version) { should match(/^2\.4/) }
end
