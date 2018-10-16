# frozen_string_literal: true

tcb = 'django_platform'

# Pip 18.1 broke poise-python
# Set to true for the latest
default['poise-python']['options']['pip_version'] = '18.0'
