# frozen_string_literal: true

tcb = 'se_django_app'

default[tcb]['apache_user'] = if platform_family?('debian')
                                'root'
                              else
                                'apache'
                              end
