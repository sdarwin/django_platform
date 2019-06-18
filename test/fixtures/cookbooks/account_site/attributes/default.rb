# frozen_string_literal: true

default['nix_baseline']['hostname'] = 'account'
default['nix_baseline']['domain'] = 'io.alaska.edu'

default['http_platform']['admin_email'] = 'ua-oit-se@alaska.edu'
default['http_platform']['cert']['organization'] = 'University of Alaska'
default['http_platform']['cert']['org_unit'] = 'OIT'

default['django_platform']['app_repo']['rel_path_to_manage_directory'] = 'app'
default['django_platform']['app_repo']['rel_path_to_site_directory'] = 'app/account_site'
default['django_platform']['app_repo']['rel_path_to_pip_requirements'] = 'requirements.txt'
default['django_platform']['app_repo']['rel_path_to_static_directory'] = 'static'
default['django_platform']['app_repo']['rel_path_to_sqlite_db'] = 'db.sqlite3'

default['django_platform']['app_repo']['git_host'] = 'github.alaska.edu'
default['django_platform']['app_repo']['git_user'] = 'OIT-CSS'
default['django_platform']['app_repo']['git_repo'] = 'ua_account_site'
default['django_platform']['app_repo']['git_revision'] = 'deploy_fixes'

default['django_platform']['app_repo']['additional_recipes_before_migration'] = ['account_site::_config']

default['django_platform']['git_ssh_key']['vault_data_bag'] = 'github'
default['django_platform']['git_ssh_key']['vault_bag_item'] = 'ualaska'
default['django_platform']['git_ssh_key']['vault_item_key'] = 'oit-se-github-user-key'
