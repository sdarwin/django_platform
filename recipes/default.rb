# frozen_string_literal: true

tcb = 'django_platform'

include_recipe "#{tcb}::apache"

include_recipe "#{tcb}::user"

include_recipe "#{tcb}::database"

include_recipe "#{tcb}::python"

include_recipe "#{tcb}::app"
