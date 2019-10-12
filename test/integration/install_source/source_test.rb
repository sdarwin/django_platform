# frozen_string_literal: true

require_relative '../helpers'

describe file(path_to_openssl) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file(path_to_sqlite) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file(path_to_python) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe pip('Django', path_to_pip) do
  it { should be_installed }
  its('version') { should match('2.2') }
end
