# frozen_string_literal: true

include_recipe 'django_platform::firewall'

include_recipe 'django_platform::database'

include_recipe 'django_platform::apache'

include_recipe 'django_platform::user'

include_recipe 'django_platform::python'
