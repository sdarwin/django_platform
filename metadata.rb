# frozen_string_literal: true

name 'se_django_app'
maintainer 'OIT Systems Engineering'
maintainer_email 'ua-oit-se@alaska.edu'
license 'MIT'
description 'Installs/Configures the platform and deploys a Django Application from a git repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.alaska.edu/oit-cookbooks/se_django_app/issues' if respond_to?(:issues_url)
source_url 'https://github.alaska.edu/oit-cookbooks/se_django_app' if respond_to?(:source_url)

version '0.1.0'

supports 'centos', '>= 7'
supports 'ubuntu', '>= 18.04'

chef_version '>= 13.0.0' if respond_to?(:chef_version)

depends 'apache2'
depends 'firewall'
depends 'se-nix-baseline'
depends 'se-nix-users'
depends 'yum-epel'
