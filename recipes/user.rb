# frozen_string_literal: true

tcb = 'se_django_app'

user 'django'

group 'django' do
  members ['django', node[tcb]['apache_user']]
end
