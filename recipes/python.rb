# frozen_string_literal: true

tcb = 'django_platform'

# We want to run django 2.1
# Django 2.1 requires python 3.5 and CentOS 7 ships with 3.3, so we must install non-standard python

include_recipe 'yum-epel::default'

# We should use a virtual environment, but poise-python is busted as of pip 18.1 release
python_runtime '3' do
  options package_name: python_package_name
  pip_version false
  setuptools_version false
  wheel_version false
end
package python_package_prefix + 'pip' if busted_poise?
package python_package_prefix + 'setuptools' if busted_poise?
package python_package_prefix + 'wheel' if busted_poise?

python_virtualenv '/home/django/env' do
  user 'django'
  group 'django'
  python '3'
  pip_version true
  setuptools_version true
  wheel_version true
  only_if { !busted_poise? }
end

node[tcb]['python']['packages_to_install'].each do |package, version|
  python_package package do
    python '3' if busted_poise?
    virtualenv '/home/django/env' unless busted_poise?
    version version if version
  end
end
