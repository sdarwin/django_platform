# frozen_string_literal: true

tcb = 'se_django_app'

# Password for DB
default[tcb]['db_password']['vault_data_bag'] = 'passwords' # The name of the vault data bag
default[tcb]['db_password']['vault_bag_item'] = 'django_db' # item inside the data bag (json file)
default[tcb]['db_password']['vault_item_key'] = 'password' # The key for password within the json object
