# frozen_string_literal: true

tcb = 'django_platform'

# The url of the git server
default[tcb]['app_repo']['git_host'] = 'github.com'

# The user/organization on the server; must be set or an exception is raised
default[tcb]['app_repo']['git_user'] = nil

# The name of the repo; must be set or an exception is raised
default[tcb]['app_repo']['git_repo'] = nil

# This is often changed during development and testing, e.g. 'staging', 'deploy'
default[tcb]['app_repo']['git_revision'] = 'master'

# Hash of environment variables to pass to git repo
default[tcb]['app_repo']['environment'] = {}

# The relative path to the requirements document, from repo root
# If non-nil, pip will be used to install the requirements
default[tcb]['app_repo']['rel_path_to_pip_requirements'] = nil

# The relative path to the directory that contains manage.py, from repo root
# Must be set or an exception is raised
default[tcb]['app_repo']['rel_path_to_http_root'] = nil

# The relative path to the directory that contains wsgi.py, from repo root
# Must be set or an exception is raised
default[tcb]['app_repo']['rel_path_to_site_directory'] = nil

# The relative path to the static directory (the target of collectstatic), from repo root
# Must be set or an exception is raised
default[tcb]['app_repo']['rel_path_to_static_directory'] = nil

# An array of management commands to call when the repo updates, after migration and (possibly) collectstatic
default[tcb]['app_repo']['additional_management_commands'] = []
