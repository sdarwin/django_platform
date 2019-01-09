# Django Platform

__Maintainer: OIT Systems Engineering__ (<ua-oit-se@alaska.edu>)

## Purpose

This is a baseline cookbook that installs/configures a platform consisting of Python 3 and Django 2.
It then deploys a Django application from a git repository.

Django is run on an Apache instance that is configured using [http_platform](https://github.com/ualaska-it/http_platform).

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
* CentOS

### Dependencies

This cookbook does not constrain its dependencies because it is intended as a utility library.
It should ultimately be used within a wrapper cookbook.

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
Defaults to `node['http_platform']['apache']['paths_to_additional_configs'].merge('conf.d/django-host.conf' => '')`.
The list of config files to enable on the virtual host,
As with the default from the [http_platform](https://github.com/ualaska-it/http_platform), this should be merged instead of overridden unless a custom server configuration is desired.

* `node['http_platform']['www']['header_policy']['referrer']`.
Defaults to `'"strict-origin"'`.
The referrer policy.
Django forms use a CSRF token to mitigate cross-site forgery attacks.
This requires the referrer to be included in the header.
This setting provides the referrer only for HTTPS traffic to mitigate other vulnerability; HTTP is redirected to HTTPS by the default [http_platform](https://github.com/ualaska-it/http_platform) configuration.

## Examples

This is an application cookbook; no custom resources are provided.
See recipes and attributes for details of what this cookbook does.

## Development

See CONTRIBUTING.md and TESTING.md.
