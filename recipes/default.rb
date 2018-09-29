# frozen_string_literal: true

include_recipe 'se-nix-users::default'
include_recipe 'se-nix-baseline::default'
include_recipe 'django_platform::firewall'

include_recipe 'django_platform::database'

include_recipe 'django_platform::apache'

include_recipe 'django_platform::user'

include_recipe 'django_platform::python'
