# frozen_string_literal: true

tcb = 'django_platform'

# Pip 18.1 broke poise-python
# Set to true for the latest
default['poise-python']['options']['pip_version'] = '18.0'

# A Hash of package name to version
# If version is empty, the latest will be installed
# Defaults to { 'Django' => '' } to install the latest version of Django
default[tcb]['python']['packages_to_install'] = {
  # These are included so that they can be upgraded; they are always installed on the first run
  pip: '',
  wheel: '',
  setuptools: '',
  # CentOS/EPEL does not supply a package for WSGI that supports Python 3
  mod_wsgi: '',
  Django: ''
}
