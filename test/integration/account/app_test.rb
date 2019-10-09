# frozen_string_literal: true

require_relative '../helpers'

describe file('/var/log/django') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by django_user }
  it { should be_grouped_into django_group }
end

describe file('/home/django/.ssh/known_hosts') do
  # Basics tested in default suite
  its(:content) { should match(/github\.alaska\.edu ssh-rsa/) }
end

describe file('/opt/chef/idempotence/known_host_github.alaska.edu.txt') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match('github.alaska.edu') }
end

describe pip('django-python3-ldap', path_to_pip) do
  it { should be_installed }
end

describe pip('django-widget-tweaks', path_to_pip) do
  it { should be_installed }
end

describe pip('ldap3', path_to_pip) do
  it { should be_installed }
end

describe pip('requests', path_to_pip) do
  it { should be_installed }
end
