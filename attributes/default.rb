# frozen_string_literal: true

tcb = 'django_platform'

apache = default['http_platform']['apache']

apache['extra_mods_to_install'] = apache['extra_mods_to_install'].merge('alias' => '')

apache['paths_to_additional_configs'] = apache['paths_to_additional_configs'].merge(
  'conf-available/django-host.conf' => ''
)

default['http_platform']['www']['header_policy']['referrer'] = '"strict-origin"'

# This is not yet implemented/documented
default[tcb]['configure_postgres'] = false
