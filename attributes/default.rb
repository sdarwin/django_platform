# frozen_string_literal: true

apache = default['http_platform']['apache']

# mod_wsgi is always installed; clients should merge this attribute rather than overwrite
apache['extra_mods_to_install'] = apache['extra_mods_to_install'].merge('alias' => '')

apache['paths_to_additional_configs'] = apache['paths_to_additional_configs'].merge('conf.d/django-host.conf' => '')

default['http_platform']['www']['header_policy']['referrer'] = '"strict-origin"'
