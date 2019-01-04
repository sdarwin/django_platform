# frozen_string_literal: true

require_relative '../helpers'

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
