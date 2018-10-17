# frozen_string_literal: true

module DjangoPlatform
  # This module implements shared utility code for consistency with dependent cookbooks
  module Helper
    TCB = 'django_platform'

    def apache_user
      user =
        if node['platform_family'] == 'debian'
          'root'
        else
          'apache'
        end
      return user
    end

    def python_package_name
      package =
        if node['platform_family'] == 'debian'
          'python3'
        else
          'rh-python36'
        end
      return package
    end

    def python_package_prefix
      package =
        if node['platform_family'] == 'debian'
          'python3-'
        else
          'rh-python36-python-'
        end
      return package
    end

    def busted_poise?
      return false
    end
  end
end

Chef::Provider.include(DjangoPlatform::Helper)
Chef::Recipe.include(DjangoPlatform::Helper)
Chef::Resource.include(DjangoPlatform::Helper)
