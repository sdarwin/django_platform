# frozen_string_literal: true

tcb = 'django_platform'

default[tcb]['app_repo']['git_protocol'] = 'git@'

default[tcb]['app_repo']['git_host'] = 'github.com'

default[tcb]['app_repo']['git_user'] = nil

default[tcb]['app_repo']['git_repo'] = nil

default[tcb]['app_repo']['git_revision'] = 'master'

default[tcb]['app_repo']['git_submodule_hosts'] = ['github.com']

default[tcb]['app_repo']['environment'] = {}

default[tcb]['app_repo']['rel_path_to_pip_requirements'] = nil

default[tcb]['app_repo']['rel_path_to_manage_directory'] = nil

default[tcb]['app_repo']['rel_path_to_site_directory'] = nil

default[tcb]['app_repo']['rel_path_to_static_directory'] = nil

default[tcb]['app_repo']['rel_path_to_sqlite_db'] = nil

default[tcb]['app_repo']['additional_recipes_before_checkout'] = []

default[tcb]['app_repo']['additional_recipes_before_install'] = []

default[tcb]['app_repo']['additional_recipes_before_migration'] = []

default[tcb]['app_repo']['additional_management_commands'] = []

default[tcb]['app_repo']['additional_shell_scripts'] = []

default[tcb]['app_repo']['git_repo_updated'] = false
