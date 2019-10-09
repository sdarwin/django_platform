# frozen_string_literal: true

default['http_platform']['admin_email'] = 'ua-oit-se@alaska.edu'
default['http_platform']['cert']['organization'] = 'University of Alaska'
default['http_platform']['cert']['org_unit'] = 'OIT'

default['django_platform']['app_repo']['rel_path_to_manage_directory'] = 'app'
default['django_platform']['app_repo']['rel_path_to_site_directory'] = 'app/django_default_site'
default['django_platform']['app_repo']['rel_path_to_static_directory'] = 'static'
default['django_platform']['app_repo']['rel_path_to_sqlite_db'] = 'db.sqlite3'

default['django_platform']['app_repo']['git_protocol'] = 'https://'
default['django_platform']['app_repo']['git_user'] = 'calsev'
default['django_platform']['app_repo']['git_repo'] = 'django_default_site'
