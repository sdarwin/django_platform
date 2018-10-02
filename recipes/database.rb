# frozen_string_literal: true

tcb = 'django_platform'

# Will raise 404 error if not found
db_secret = chef_vault_item(
  node[tcb]['db_password']['vault_data_bag'],
  node[tcb]['db_password']['vault_bag_item']
)
raise 'Unable to retrieve data bag for SSH key' if db_secret.nil?
db_password = db_secret[node[tcb]['db_password']['vault_item_key']]
raise 'Unable to retrieve SSH key' if db_password.nil?

postgresql_server_install 'Install PostgreSQL' do
  password db_password
end
