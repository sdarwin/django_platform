# frozen_string_literal: true

tcb = 'ua_account_sync'

include_recipe 'yum-epel' if platform_family?('rhel')
include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'

service node[tcb]['apache_service']
