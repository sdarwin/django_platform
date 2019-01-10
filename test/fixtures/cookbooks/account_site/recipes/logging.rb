# frozen_string_literal: true

directory '/var/log/django' do
  owner 'django'
  group 'django'
  mode '775'
end
