# frozen_string_literal: true

tcb = 'se_django_app'

default[tcb]['apache']['service_name'] = if platform_family?('debian')
                                   'apache2'
                                 else
                                   'httpd'
                                 end
