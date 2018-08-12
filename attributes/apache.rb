# frozen_string_literal: true

tcb = 'se_django_app'

default[tcb]['apache_service'] = if platform_family?('debian')
                                   'apache2'
                                 else
                                   'httpd'
                                 end
