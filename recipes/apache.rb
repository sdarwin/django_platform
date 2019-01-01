# frozen_string_literal: true

node.default['http_platform']['www']['document_root'] = File.join(path_to_app_repo, rel_path_to_http_root)

include_recipe 'http_platform::default'

# Apache cookbook mod_wsgi does not support Python 3
# This is used for pip install of wsgi
package apache_dev_package_name
