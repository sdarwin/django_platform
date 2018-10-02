# frozen_string_literal: true

# mod_wsgi is always installed; clients should merge this attribute rather than overwrite
default['http_platform']['apache']['extra_mods_to_install'] = { 'wsgi' => '' }
