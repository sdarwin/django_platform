# frozen_string_literal: true

include_recipe 'se-nix-users::default'
include_recipe 'se-nix-baseline::default'

include_recipe 'se_django_app::firewall'

include_recipe 'se_django_app::database'

include_recipe 'se_django_app::apache'

include_recipe 'se_django_app::user'

include_recipe 'se_django_app::python'
