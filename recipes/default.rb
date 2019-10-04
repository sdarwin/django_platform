# frozen_string_literal: true

tcb = 'django_platform'

include_recipe "#{tcb}::_general"

include_recipe "#{tcb}::_apache"

include_recipe "#{tcb}::_user"

include_recipe "#{tcb}::_database" if node[tcb]['configure_postgres']

include_recipe "#{tcb}::_python"

include_recipe "#{tcb}::_app"
