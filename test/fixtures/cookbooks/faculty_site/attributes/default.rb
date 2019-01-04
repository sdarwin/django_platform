# frozen_string_literal: true

default['http_platform']['admin_email'] = 'ua-oit-se@alaska.edu'

default['django_platform']['app_repo']['rel_path_to_manage_directory'] = 'app'
default['django_platform']['app_repo']['rel_path_to_site_directory'] = 'app/faculty_site'
default['django_platform']['app_repo']['rel_path_to_pip_requirements'] = 'requirements.txt'
default['django_platform']['app_repo']['rel_path_to_static_directory'] = 'app/static'
default['django_platform']['app_repo']['rel_path_to_sqlite_db'] = 'db.sqlite3'

default['django_platform']['app_repo']['git_user'] = 'calsev'
default['django_platform']['app_repo']['git_repo'] = 'mcs_faculty_website'

default['django_platform']['app_repo']['additional_shell_scripts'] = ['database.sh']

default['django_platform']['git_ssh_key']['vault_data_bag'] = 'github'
default['django_platform']['git_ssh_key']['vault_bag_item'] = 'calsev'
default['django_platform']['git_ssh_key']['vault_item_key'] = 'key'
