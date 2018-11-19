# frozen_string_literal: true

tcb = 'django_platform'

# Create a system user with no shell, mostly for kitchen testing
default[tcb]['django_is_system_user'] = true

# SSH private key for git user
default[tcb]['git_ssh_key']['vault_data_bag'] = 'github' # The name of the vault data bag
default[tcb]['git_ssh_key']['vault_bag_item'] = 'ualaska' # item inside the data bag (json file)
default[tcb]['git_ssh_key']['vault_item_key'] = 'oit-se-github-user-key' # The key for password within the json object
