# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe user('django') do
  it { should exist }
  its('group') { should eq 'django' }
  its('groups') { should eq ['django'] }
  its('home') { should eq '/home/django' }
  its('shell') { should eq '/usr/sbin/nologin' }
end

describe user(apache_user(node)) do
  it { should exist }
  its('group') { should eq apache_user(node) }
  its('groups') { should eq [apache_user(node), 'django'] }
  its('home') { should eq apache_home_dir(node) }
  its('shell') { should eq apache_shell(node) }
end

describe directory('/home/django') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o750 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end

describe directory('/home/django/.ssh') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o700 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end

describe file('/home/django/.ssh/id_rsa') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o700 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
  its(:content) { should match 'BEGIN OPENSSH PRIVATE KEY' }
end
