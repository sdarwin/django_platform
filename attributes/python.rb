# frozen_string_literal: true

tcb = 'django_platform'

default['poise-python']['options']['pip_version'] = '18.0'

default[tcb]['openssl']['version_to_install'] = nil
default[tcb]['sqlite']['version_to_install'] = nil
default[tcb]['python']['version_to_install'] = '3.7.4'

default[tcb]['python']['packages_to_install'] = {
  pip: '',
  wheel: '',
  setuptools: '',
  mod_wsgi: '',
  Django: ''
}
