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

    def path_to_system_python
      binary =
        if node['platform_family'] == 'debian'
          '/usr/bin/python3'
        else
          '/usr/bin/python36'
        end
      return binary
    end

    def path_to_app_repo
      return '/home/django/repo'
    end

    def path_to_venv
      return '/home/django/env'
    end

    def path_to_site_directory
      site_dir = node[TCB]['app_repo']['path_to_site_directory']
      raise 'node[\'django_platform\'][\'app_repo\'][\'path_to_site_directory\'] must be set' if site_dir.nil?

      return File.join(path_to_app_repo, site_dir)
    end

    def path_to_static_dir
      static_dir = node[TCB]['app_repo']['path_to_static_directory']
      raise 'node[\'django_platform\'][\'app_repo\'][\'path_to_static_directory\'] must be set' if static_dir.nil?

      return File.join(path_to_app_repo, static_dir)
    end

    def django_http_root
      doc_root = node[TCB]['app_repo']['path_to_http_root']
      raise 'node[\'django_platform\'][\'app_repo\'][\'path_to_http_root\'] must be set' if doc_root.nil?

      return File.join(path_to_app_repo, doc_root)
    end

    def path_to_manage_py
      return File.join(django_http_root, 'manage.py')
    end

    def vault_secret(bag, item, key)
      # Will raise 404 error if not found
      item = chef_vault_item(
        bag,
        item
      )
      raise 'Unable to retrieve vault item' if item.nil?

      secret = item[key]
      raise 'Unable to retrieve item key' if secret.nil?

      return secret
    end
  end
end

Chef::Provider.include(DjangoPlatform::Helper)
Chef::Recipe.include(DjangoPlatform::Helper)
Chef::Resource.include(DjangoPlatform::Helper)
