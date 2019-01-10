# frozen_string_literal: true

tcb = 'account_site'

default[tcb]['domain_user'] = 'seadmin'

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
