# frozen_string_literal: true

tcb = 'se_django_app'

default[tcb]['apache_user'] = if platform_family?('debian')
                                'root'
                              else
                                'apache'
                              end

# SSH private key for git user
default[tcb]['git_ssh_key']['vault_data_bag'] = 'github' # The name of the vault data bag
default[tcb]['git_ssh_key']['vault_bag_item'] = 'ualaska' # item inside the data bag (json file)
default[tcb]['git_ssh_key']['vault_item_key'] = 'oit-se-github-user-key' # The key for password within the json object
