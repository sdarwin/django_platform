# frozen_string_literal: true

include_recipe 'se-nix-users::default'
include_recipe 'se-nix-baseline::default'

include_recipe 'app_account_portal::firewall'

include_recipe 'app_account_portal::apache'

include_recipe 'app_account_portal::user'

include_recipe 'app_account_portal::python'
