# frozen_string_literal: true

tcb = 'ua_account_sync'

default[tcb]['apache_service'] = if platform_family?('debian')
                                   'apache2'
                                 else
                                   'httpd'
                                 end
