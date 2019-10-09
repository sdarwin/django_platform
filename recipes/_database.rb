# frozen_string_literal: true

tcb = 'django_platform'

bag = node[tcb]['db_password']['vault_data_bag']
item = node[tcb]['db_password']['vault_bag_item']
key = node[tcb]['db_password']['vault_item_key']

postgresql_server_install 'Install PostgreSQL Server' do
  version '10'
  password(lazy { vault_secret(bag, item, key) })
end
