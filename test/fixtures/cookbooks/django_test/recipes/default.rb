# frozen_string_literal: true

tcb = 'django_test'

include_recipe 'django_platform::default'

include_recipe "#{tcb}::config"
