# frozen_string_literal: true

tcb = 'django_platform'

default['poise-python']['options']['pip_version'] = '18.0'

default[tcb]['python']['packages_to_install'] = {
  pip: '',
  wheel: '',
  setuptools: '',
  mod_wsgi: '',
  Django: ''
}
