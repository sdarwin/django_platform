# frozen_string_literal: true

tcb = 'se_django_app'

user 'django' do
  system true
  shell '/usr/sbin/nologin'
  manage_home false # Owned resources are in /opt
end

group 'django' do
  members ['django', node[tcb]['apache_user']]
end
