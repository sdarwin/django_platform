# frozen_string_literal: true

tcb = 'django_platform'

user 'django' do
  system true
  shell '/usr/sbin/nologin'
  manage_home false # Owned resources are in /opt
end

group 'django' do
  members ['django', node[tcb]['apache_user']]
end
