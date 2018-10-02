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
