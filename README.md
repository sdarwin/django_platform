# Account Portal Application

__Maintainer: OIT Systems Engineering__ (<ua-oit-se@alaska.edu>)

## Purpose

This is an application cookbook to create an instance of the UA Account Portal.

## Requirements

### Chef

This cookbook requires Chef 13+

### Platforms

Supported Platform Families:

* Ubuntu

Platforms validated via Test Kitchen:

* Ubuntu

## Resources

This cookbook provides no custom resources.

## Recipes

### app_account_portal::default

This recipe configures the host system and deploys the Django application.

__Attributes__

## Examples

This is an application cookbook; no custom resources are provided.  See recipes and attributes for details of what this cookbook does.

## Development

Development should follow [GitHub Flow](https://guides.github.com/introduction/flow/) to foster some shared responsibility.

* Fork/branch the repository
* Make changes
* Fix all Rubocop (`rubocop`) and Foodcritic (`foodcritic .`) offenses
* Write smoke tests that reasonably cover the changes (`kitchen verify`)
* Pass all smoke tests
* Submit a Pull Request using Github
* Wait for feedback and merge from a second developer

### Requirements

For running tests in Test Kitchen a few dependencies must be installed.

* [ChefDK](https://downloads.chef.io/chef-dk/)
* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install the dependency tree with `berks install`
* Install the Vagrant WinRM plugin:  `vagrant plugin install vagrant-winrm`
