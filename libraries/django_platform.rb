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
          'python36'
        end
      return package
    end

    def python_package_prefix
      package =
        if node['platform_family'] == 'debian'
          'python3-'
        else
          'python36-'
        end
      return package
    end

    def python_command
      package =
        if node['platform_family'] == 'debian'
          'python3'
        else
          'python36'
        end
      return package
    end

    def path_to_venv
      return '/home/django/env'
    end

    def path_to_venv_python
      return File.join(path_to_venv, 'bin/python')
    end

    def django_http_root
      doc_root = node[TCB]['app_repo']['path_to_http_root']
      raise 'node[\'django_platform\'][\'app_repo\'][\'path_to_http_root\'] must be set' if doc_root.nil?
      return File.join('/home/django/app', doc_root)
    end
  end
end

Chef::Provider.include(DjangoPlatform::Helper)
Chef::Recipe.include(DjangoPlatform::Helper)
Chef::Resource.include(DjangoPlatform::Helper)
