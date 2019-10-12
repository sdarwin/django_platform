# frozen_string_literal: true

# Django 2.1 requires python 3.5 and CentOS 7 ships with 3.3, so we must install EPEL python

include_recipe 'yum-epel::default' if node['platform_family'] == 'rhel' && node['platform_version'].to_f < 8

package python_package_name
package "#{python_package_prefix}venv" do
  only_if { node['platform_family'] == 'debian' }
end

# We may need to build some wheels from source
package 'gcc'
package python_dev_package_name
