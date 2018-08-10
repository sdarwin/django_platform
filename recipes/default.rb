# frozen_string_literal: true

include_recipe 'se-nix-baseline::default'

# Allow Web
firewall_rule 'Allow HTTP/HTTPS' do
  port [80, 443]
  protocol :tcp
  command :allow
end
