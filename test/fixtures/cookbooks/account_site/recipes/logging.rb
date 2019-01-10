# frozen_string_literal: true

tcb = 'account_site'

directory '/var/log/django' do
  owner 'django'
  group 'django'
  mode '775'
end
