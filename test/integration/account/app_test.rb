# frozen_string_literal: true

require_relative '../helpers'

describe file('/var/log/django') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end

describe file('/home/django/.ssh/known_hosts') do
  # Basics tested in default suite
  its(:content) { should match(/github\.alaska\.edu ssh-rsa/) }
end

describe pip('django-python3-ldap', path_to_pip) do
  it { should be_installed }
end

describe pip('requests', path_to_pip) do
  it { should be_installed }
end
