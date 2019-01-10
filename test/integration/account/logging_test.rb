# frozen_string_literal: true

describe file('/home/django/repo/app/shared_app/conf/config.ini') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by 'django' }
  it { should be_grouped_into 'django' }
end
