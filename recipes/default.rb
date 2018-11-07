# frozen_string_literal: true

node.default['http_platform']['www']['document_root'] = django_http_root

include_recipe 'http_platform::default'

include_recipe 'django_platform::user'

include_recipe 'django_platform::database'

include_recipe 'django_platform::python'

include_recipe 'django_platform::app'
