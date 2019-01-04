# frozen_string_literal: true

include_recipe 'http_platform::default'

# Apache cookbook mod_wsgi does not support Python 3
# This is used for pip install of wsgi
package apache_dev_package_name
