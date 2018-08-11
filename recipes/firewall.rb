# frozen_string_literal: true

# Allow WWW
firewall_rule 'Allow HTTP/HTTPS' do
  port [80, 443]
  protocol :tcp
  command :allow
end
