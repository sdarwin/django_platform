# frozen_string_literal: true

tcb = 'se_django_app'

include_recipe 'yum-epel' if platform_family?('rhel')
include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_wsgi'
node[tcb]['apache']['additional_modules_to_install'].each do |mod|
  include_recipe "apache2::#{mod}"
end

service node['apache']['service_name']
