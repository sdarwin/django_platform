# frozen_string_literal: true

tcb = 'app_account_portal'

default[tcb]['apache_user'] = if platform_family?('debian')
                                'root'
                              else
                                'apache'
                              end
