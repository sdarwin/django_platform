# Django Platform

[![License](https://img.shields.io/github/license/ualaska-it/django_platform.svg)](https://github.com/ualaska-it/django_platform)
[![GitHub Tag](https://img.shields.io/github/tag/ualaska-it/django_platform.svg)](https://github.com/ualaska-it/django_platform)
[![Build status](https://ci.appveyor.com/api/projects/status/7sjr3vr50j5e8ymy/branch/master?svg=true)](https://ci.appveyor.com/project/UAlaska/django-platform/branch/master)

__Maintainer: OIT Systems Engineering__ (<ua-oit-se@alaska.edu>)

## Purpose

This is a baseline cookbook that installs/configures a platform consisting of Python 3 and Django 2.
It then deploys a Django application from a git repository.

Django is run on an Apache instance that is configured using [http_platform](https://github.com/ualaska-it/http_platform).

It is optional to install OpenSSL, SQLite, and Python from packages or sources, see `node['django_platform']['python']['install_method']`.
Build times for install from source can be long, especially for Python 3.7.
The source build after changing Python version can take more than a half hour.
On burstable instance types, CPU credits tend to deplete on small instances (smaller than an EC2 t3.medium).

## Requirements

### Chef

This cookbook requires Chef 14+

### Platforms

Supported Platform Families:

* Debian
  * Ubuntu, Mint
* Red Hat Enterprise Linux
  * Amazon, CentOS, Oracle

Platforms validated via Test Kitchen:

* Ubuntu
* Debian
* CentOS
* Oracle

### Dependencies

This cookbook does not constrain its dependencies because it is intended as a utility library.
It should ultimately be used within a wrapper cookbook.

Note:

Version 2 of this cookbook requires [apache2 cookbook](https://github.com/sous-chefs/apache2) >= 6.0.
To support older apache2 versions, use version 1 of this cookbook.

## Resources

This cookbook provides no custom resources.

## Recipes

### django_platform::default

This recipe configures the host platform and deploys a Django application.
The [http_platform](https://github.com/ualaska-it/http_platform) recipe is run as part of this.

## Attributes

### Default

Some attributes are overridden from the [http_platform](https://github.com/ualaska-it/http_platform) cookbook.

* `node['http_platform']['apache']['extra_mods_to_install']`.
Defaults to `node['http_platform']['apache']['extra_mods_to_install'].merge('alias' => '')`.
The list of Apache mods to install.
Clients should merge this attribute rather than overwrite because mod alias is required for Django to function.
In addition, mod_wsgi is installed by Pip.

* `node['http_platform']['apache']['paths_to_additional_configs']`.
Defaults to `node['http_platform']['apache']['paths_to_additional_configs'].merge('conf-available/django-host.conf' => '')`.
The list of config files to enable on the virtual host,
As with the default from the [http_platform](https://github.com/ualaska-it/http_platform), this should be merged instead of overridden unless a custom server configuration is desired.

* `node['http_platform']['www']['header_policy']['referrer']`.
Defaults to `'"strict-origin"'`.
The referrer policy.
Django forms use a CSRF token to mitigate cross-site forgery attacks.
This requires the referrer to be included in the header.
This setting provides the referrer only for HTTPS traffic to mitigate other vulnerability; HTTP is redirected to HTTPS by the default [http_platform](https://github.com/ualaska-it/http_platform) configuration.

On RHEL-based distros, SE Linux must be set to permissive to perform some actions.
To do this the [selinux cookbook](https://github.com/chef-cookbooks/selinux) is used.
The state for SE Linux is determined by `node['selinux']['state']` and is set to `'permissive'` by default in this cookbook.

### App

__Git checkout__

This cookbook assumes the django application is contained in a git repo.
Both SSH and HTTPS access are supported.
Submodules will be checked out recursively, and these can also use SSH or HTTPS.

* `node['django_platform']['app_repo']['git_protocol']`.
Defaults to `'git@'`.
The protocol to use to fetch the git repo that contains the Django application.
Valid values are 'git@' and 'https://'.

* `node['django_platform']['app_repo']['git_host']`.
Defaults to `'github.com'`.
The url of the git server from which to fetch the Django application.

* `node['django_platform']['app_repo']['git_user']`.
Defaults to `nil`.
The user/organization on the git server; must be set or an exception is raised.

* `node['django_platform']['app_repo']['git_repo']`.
Defaults to `nil`.
The name of the repo within the git organization; must be set or an exception is raised.

* `node['django_platform']['app_repo']['git_revision']`.
Defaults to `'master'`.
The branch, tag, or commit to check out.
This is often changed during development and testing, e.g. to 'staging', 'deploy'.

* `node['django_platform']['app_repo']['git_submodule_hosts']`.
Defaults to `['github.com']`.
A list of hosts from which submodules are cloned.
Used to build the known hosts file so the first attempt to clone the repo succeeds.

* `node['django_platform']['app_repo']['environment']`.
Defaults to `{}`.
A hash of environment variables that is passed to the [git resource](https://docs.chef.io/resource_git.html).

__Server hooks__

Deployment of the app requires several hooks into the application repo so that server paths can be set.

* `node['django_platform']['app_repo']['rel_path_to_pip_requirements']`.
Defaults to `nil`.
The relative path to the requirements document, from repo root.
If non-nil, pip will be used to install the requirements.

* `node['django_platform']['app_repo']['rel_path_to_manage_directory']`.
Defaults to `nil`.
The relative path to the directory that contains manage.py, from repo root.
Must be set or an exception is raised.

* `node['django_platform']['app_repo']['rel_path_to_site_directory']`.
Defaults to `nil`.
The relative path to the directory that contains settings.py and wsgi.py, from repo root.
Must be set or an exception is raised.

* `node['django_platform']['app_repo']['rel_path_to_static_directory']`.
Defaults to `nil`.
The relative path to the directory from which static files are to be served, from repo root.
If `STATIC_ROOT` is set in settings.py, `manage.py collectstatic` will be run every time the git repo changes.
Must be set or an exception is raised.

* `node['django_platform']['app_repo']['rel_path_to_sqlite_db']`.
Defaults to `nil`.
The relative path to the sqlite database, from repo root.
If non-nil, permissions of this file will be managed, after all management commands and scripts have run.
Management of Postgres has not yet been implemented.

__Deployment hooks__

The platform supplies several hooks so clients can run custom code during deployment.
The checkout workflow is as follows.

* Run pre-checkout recipes, see `node['django_platform']['app_repo']['additional_recipes_before_checkout']`
* Synchronize the git repo
* Run pre-install recipes, see `node['django_platform']['app_repo']['additional_recipes_before_install']`
* If the git repo changed
  * Install all entries in `requirements.txt`, if the cookbook is configured to do so
* Run pre-migrate recipes, `node['django_platform']['app_repo']['additional_recipes_before_migration']`
* If the git repo changed
  * Migrate the database `manage.py migrate`
  * Collect static files `manage.py collectstatic`, if the Django app is configured for it
  * Run a list of custom management commands, see `node['django_platform']['app_repo']['additional_management_commands']`
  * Run a list of custom bash scripts, with the Python environment for Django activated, `node['django_platform']['app_repo']['additional_shell_scripts']`

Pre-checkout, pre-install, and pre-migrate recipes are run _unconditionally_.
A flag is provided to indicate if the repo updated.

* `node['django_platform']['app_repo']['git_repo_updated']`.
Defaults to `false`.
Set to true within a recipe if the git repo updated.
Typically used within only_if blocks to trigger deployment code on update.

For the apache/wsgi server to gain access to any file system resources, all directories and files must have the appropriate permissions.
Helpers specify the user (`django_user`) and group (`django_group`) used by the platform for file resources that are to be accessed by the server.

* `node['django_platform']['app_repo']['additional_recipes_before_checkout']`.
Defaults to `[]`.
A list of recipes to include after the `django_user` is created, but before cloning the git repo.

* `node['django_platform']['app_repo']['additional_recipes_before_install']`.
Defaults to `[]`.
A list of recipes to include after cloning the git repo, but before installing requirements.

* `node['django_platform']['app_repo']['additional_recipes_before_migration']`.
Defaults to `[]`.
A list of recipes to include after installing requirements, but before migrating the database.

* `node['django_platform']['app_repo']['additional_management_commands']`.
Defaults to `[]`.
An array of management commands to call after the repo updates.
Commands are executed in order, after migration and (possibly) collectstatic.
This attribute is included to support limited cases where an application can be deployed using only node attributes.

* `node['django_platform']['app_repo']['additional_shell_scripts']`.
Defaults to `[]`.
An array of relative paths to bash scripts, from repo root, to execute after the repo updates.
Scripts are executed in order, after all management commands.
Scripts are executed in a context where the Python environment for the Django app is activated.
This attribute is included to support limited cases where an application can be deployed using only node attributes.

### Python

RHEL and Django approaches don't align well.
The latest 2.2 LTS release of Django requires Python 3.5 and SQLite 3.8 or higher.
RHEL + EPEL provides Python 3.6, but it is compiled with an old SQLite 3.7.
For comparison, Ubuntu 16 comes with only Python 3.5, but it is compiled with SQLite 3.11.

Where possible, it is advisable to use system packages because they are better supported.
However, running newer Django versions on older distros can require installing custom libraries.
This cookbook can be used to build a custom python install.
The install method is controlled by a single switch.

* `node['django_platform']['python']['install_method']`.
Defaults to 'package'.
The method used to install Python and dependencies.
Allowable values are 'package' and 'source'.

When source install is chosen, the attributes below control the versions of Python and dependencies to install.
The attributes below are ignored for package install.

* `node['django_platform']['openssl']['version_to_install']`.
Defaults to `nil`,
The version of OpenSSL to install.
If nil, the default version for [openssl_install](https://github.com/UAlaska-IT/openssl_install) will be used.

* `node['django_platform']['sqlite']['version_to_install']`.
Defaults to `nil`,
The version of SQLite to install.
If nil, the default version for [sqlite_install](https://github.com/UAlaska-IT/sqlite_install) will be used.

* `node['django_platform']['python']['version_to_install']`.
Defaults to `3.7.4`,
The version of Python to install.

Note:

* Compile times for a full Python stack can be long, so the first run will take a while.
* Django support for Python and SQLite can be found [here](https://www.djangoproject.com/download/#supported-versions).

The Pip packages to install are set using a single attribute.

* `node['django_platform']['python']['packages_to_install']`.
Defaults to
```
{
  # These are included so that they can be upgraded; they are always installed on the first run
  pip: '',
  wheel: '',
  setuptools: '',
  # Pip install is used because CentOS/EPEL does not supply a package for WSGI that supports Python 3
  mod_wsgi: '',
  # This is unpinned; 2.2 is the latest LTS release
  Django: ''
}
```
A Hash of package name to version.
If version is empty, the latest version will be installed.
Clients should merge this attribute rather than overwrite because mod_wsgi and Django are required for the server to function.

### User

* `node['django_platform']['django_is_system_user']`.
Defaults to `true`.
If false, the django user will be configured with a shell, mostly for development and debugging.

# SSH private key for git user

If the app repo will be fetched using SSH (`node['django_platform']['app_repo']['git_protocol']`), the attributes relating to the SSH private key must be set or an exception is raised.

* `node['django_platform']['git_ssh_key']['vault_data_bag']`.
Defaults to `nil`.
The name of the vault data bag (directory) from which to fetch the SSH key.

* `node['django_platform']['git_ssh_key']['vault_bag_item']`.
Defaults to `nil`.
The item (json file) inside the data bag.

* `node['django_platform']['git_ssh_key']['vault_item_key']`.
Defaults to `nil`.
The hash key for referencing the SSH key within the json object.

## Examples

This is an application cookbook; no custom resources are provided.
See recipes and attributes for details of what this cookbook does.

Cookbooks for two sample deployments are included in test/fixtures/cookbooks.

## Development

See CONTRIBUTING.md and TESTING.md.
