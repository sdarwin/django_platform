# frozen_string_literal: true

default['http_platform']['admin_email'] = 'ua-oit-se@alaska.edu'

default['django_platform']['app_repo']['rel_path_to_manage_directory'] = 'app'
default['django_platform']['app_repo']['rel_path_to_site_directory'] = 'app/account_site'
default['django_platform']['app_repo']['rel_path_to_pip_requirements'] = 'requirements.txt'
default['django_platform']['app_repo']['rel_path_to_static_directory'] = 'app/static'
default['django_platform']['app_repo']['rel_path_to_sqlite_db'] = 'db.sqlite3'

default['django_platform']['app_repo']['git_host'] = 'github.alaska.edu'
default['django_platform']['app_repo']['git_user'] = 'OIT-CSS'
default['django_platform']['app_repo']['git_repo'] = 'ua_account_site'
