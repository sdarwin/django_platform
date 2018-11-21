# frozen_string_literal: true

default['http_platform']['admin_email'] = 'fake-it@make-it'

default['django_platform']['django_is_system_user'] = false

default['django_platform']['app_repo']['path_to_http_root'] = 'app'
default['django_platform']['app_repo']['path_to_site_directory'] = 'app/account_site'
default['django_platform']['app_repo']['path_to_pip_requirements'] = 'requirements.txt'
default['django_platform']['app_repo']['path_to_static_directory'] = 'app/static'

default['django_platform']['app_repo']['git_host'] = 'github.alaska.edu'
default['django_platform']['app_repo']['git_user'] = 'OIT-CSS'
default['django_platform']['app_repo']['git_repo'] = 'ua_account_site'
