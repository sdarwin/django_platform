# frozen_string_literal: true

tcb = 'django_platform'

node.default['http_platform']['www']['document_root'] = File.join(path_to_app_repo, rel_path_to_http_root)

include_recipe 'http_platform::default'

include_recipe "#{tcb}::user"

include_recipe "#{tcb}::database"

include_recipe "#{tcb}::python"

include_recipe "#{tcb}::app"
