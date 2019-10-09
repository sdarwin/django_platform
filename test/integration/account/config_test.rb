# frozen_string_literal: true

require_relative '../helpers'

describe file('/var/log/django') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by django_user }
  it { should be_grouped_into django_group }
end

describe file('/home/django/repo/app/shared_app/conf/config.ini') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o440 }
  it { should be_owned_by django_user }
  it { should be_grouped_into django_group }
  # rubocop:disable Metrics/LineLength
  its(:content) { should match(/user = CN=oit account admin,OU=Account Provisioning,OU=Services,OU=SW,DC=ua,DC=ad,DC=alaska,DC=edu/) }
  # rubocop:enable Metrics/LineLength
  its(:content) { should match(/base = DC=ua,DC=ad,DC=alaska,DC=edu/) }
  its(:content) { should match(/instance = prod/) }
  its(:content) { should match(/username = calsev/) }
  its(:content) { should match(/username = cjsevern/) }
  its(:content) { should match(/email_address = cjsevern@alaska.edu/) }
end
