# frozen_string_literal: true

tcb = 'se_django_app'

# The URL of the repo to clone in the app directory
# For apps within cookbooks, this will be a bit of recursion
default[tcb]['app_repo']['repository'] = 'git@github.alaska.edu:OIT-CSS/ua-account-sync'

# This is often changed during development and testing, e.g. 'staging', 'deploy'
default[tcb]['app_repo']['revision'] = 'master'

# Hash of environment variables to pass to git repo
default[tcb]['app_repo']['environment'] = {}
