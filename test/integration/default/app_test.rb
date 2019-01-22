# frozen_string_literal: true

require_relative '../helpers'

describe file('/home/django/.ssh/known_hosts') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
  its(:content) { should match(/github\.com ssh-rsa/) }
end

describe file('/opt/chef/idempotence/known_host_github.com.txt') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match('github.com') }
end

describe file('/home/django/repo') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o770 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end

describe file('/home/django/repo/db.sqlite3') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o660 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end

describe file('/home/django/repo/static/admin') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end
