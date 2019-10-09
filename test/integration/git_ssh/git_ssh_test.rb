# frozen_string_literal: true

require_relative '../helpers'

describe file('/home/django/.ssh/id_rsa') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o700 }
  it { should be_owned_by django_user }
  it { should be_grouped_into django_group }
  its(:content) { should match(/BEGIN OPENSSH PRIVATE KEY|BEGIN RSA PRIVATE KEY/) }
end
