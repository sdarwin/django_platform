# frozen_string_literal: true

tcb = 'django_platform'

default[tcb]['django_is_system_user'] = true

default[tcb]['git_ssh_key']['vault_data_bag'] = nil
default[tcb]['git_ssh_key']['vault_bag_item'] = nil
default[tcb]['git_ssh_key']['vault_item_key'] = nil
