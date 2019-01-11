# frozen_string_literal: true

name 'account_site'
maintainer 'OIT Systems Engineering'
maintainer_email 'ua-oit-se@alaska.edu'
license 'MIT'
description 'Test fixture for the django_platform cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.alaska.edu/OIT-CSS/django_platform/issues' if respond_to?(:issues_url)
source_url 'https://github.alaska.edu/OIT-CSS/django_platform' if respond_to?(:source_url)

version '1.0.0'

supports 'ubuntu', '>= 16.0'
supports 'centos', '>= 7.0'

chef_version '>= 14.0.0' if respond_to?(:chef_version)

depends 'django_platform'
