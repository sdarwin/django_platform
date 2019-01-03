# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe file('/home/django/.ssh/known_hosts') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end

describe file(path_to_django_host(node)) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match('Alias /static /home/django/repo/app/static') }
  its(:content) { should match(%r{<Directory app/static>\s+Require all granted}) }
end

describe file(path_to_django_conf(node)) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  # rubocop:disable Metrics/LineLength
  its(:content) { should match('WSGIDaemonProcess django python-home=/home/django/env python-path=/home/django/repo/app') }
  # rubocop:enable Metrics/LineLength
end

describe file('/home/django/repo/db.sqlite3') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end
