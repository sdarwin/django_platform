# frozen_string_literal: true

tcb = 'app_account_portal'

user 'django'

group 'django' do
  members ['django', node[tcb]['apache_user']]
end
