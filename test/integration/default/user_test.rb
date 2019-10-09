# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe user(django_user) do
  it { should exist }
  its('group') { should eq django_group }
  its('groups') { should eq [django_group] }
  its('home') { should eq '/home/django' }
  its('shell') { should eq '/bin/bash' }
  # its('shell') { should eq '/usr/sbin/nologin' }
end

describe user(apache_user(node)) do
  it { should exist }
  its('group') { should eq apache_user(node) }
  its('groups') { should eq [apache_user(node), django_group] }
  its('home') { should eq apache_home_dir(node) }
  its('shell') { should eq apache_shell(node) }
end

describe directory('/home/django') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o750 }
  it { should be_owned_by django_user }
  it { should be_grouped_into django_group }
end

describe directory('/home/django/.ssh') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o700 }
  it { should be_owned_by django_user }
  it { should be_grouped_into django_group }
end
