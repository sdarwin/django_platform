# frozen_string_literal: true

tcb = 'se_django_app'

# mod_ssl and mod_wsgi are always installed; use this for additional Apache2 modules
# See https://github.com/sous-chefs/apache2#recipes for a list of modules
# Use the full name of the mod recipe, e.g. 'mod_xsendfile'
default[tcb]['additional_apache_modules_to_install'] = []
