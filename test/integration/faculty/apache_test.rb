# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe file(path_to_django_host(node)) do
  # Basics tested in default suite
  # its(:content) { should match(%r{<Directory app/faculty_site>\s+<Files wsgi.py>\s+Require all granted}) }
end

describe file(path_to_django_conf(node)) do
  # Basics tested in default suite
  its(:content) { should match('WSGIScriptAlias / /home/django/repo/app/faculty_site/wsgi\.py') }
end
