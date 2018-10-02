# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe user('django') do
  it { should exist }
  its('group') { should eq 'django' }
  its('groups') { should eq ['django'] }
  its('home') { should eq '/home/django' }
  its('shell') { should eq '/bin/nologin' }
end
