# frozen_string_literal: true

require_relative '../helpers'

describe file('/home/django/repo/app/shared/conf/config.ini') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o440 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
  its(:content) { should match(/user = seadmin/) }
  its(:content) { should match(/host = calsev/) }
  its(:content) { should match(/user = cjsevern/) }
  its(:content) { should match(/mail = cjsevern@alaska.edu/) }
end
