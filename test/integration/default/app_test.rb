# frozen_string_literal: true

require_relative '../helpers'

describe file('/home/django/.ssh/known_hosts') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
  its(:content) { should match(/github\.alaska\.edu ssh-rsa/) }
end
