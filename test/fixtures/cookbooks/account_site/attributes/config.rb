# frozen_string_literal: true

tcb = 'account_site'

# rubocop:disable Metrics/LineLength
default[tcb]['domain_user'] = 'CN=oit account admin,OU=Account Provisioning,OU=Services,OU=SW,DC=ua,DC=ad,DC=alaska,DC=edu'
# rubocop:enable Metrics/LineLength

default[tcb]['domain_password']['vault_data_bag'] = 'passwords'
default[tcb]['domain_password']['vault_bag_item'] = 'oit-account-admin'
default[tcb]['domain_password']['vault_item_key'] = 'password'

default[tcb]['email_user'] = 'calsev'

default[tcb]['email_password']['vault_data_bag'] = 'passwords'
default[tcb]['email_password']['vault_bag_item'] = 'calsev'
default[tcb]['email_password']['vault_item_key'] = 'password'

default[tcb]['local_user'] = 'cjsevern'
default[tcb]['local_email'] = 'cjsevern@alaska.edu'

default[tcb]['local_password']['vault_data_bag'] = 'passwords'
default[tcb]['local_password']['vault_bag_item'] = 'cjsevern'
default[tcb]['local_password']['vault_item_key'] = 'password'
