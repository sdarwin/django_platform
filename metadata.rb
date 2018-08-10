# frozen_string_literal: true

name 'app_account_portal'
maintainer 'OIT Systems Engineering'
maintainer_email 'ua-oit-se@alaska.edu'
license 'MIT'
description 'Installs/Configures app_account_portal'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.alaska.edu/oit-cookbooks/app_account_portal/issues' if respond_to?(:issues_url)
source_url 'https://github.alaska.edu/oit-cookbooks/app_account_portal' if respond_to?(:source_url)

version '0.1.0'

supports ubuntu

chef_version '>= 13.0.0' if respond_to?(:chef_version)

depends 'se-nix-baseline'
