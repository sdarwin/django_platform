# frozen_string_literal: true

tcb = 'account_site'

include_recipe 'django_platform::default'

include_recipe "#{tcb}::config"

include_recipe "#{tcb}::logging"
