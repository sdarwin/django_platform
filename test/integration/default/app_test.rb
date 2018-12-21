# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe file("#{path_to_conf_directory(node)}/django.conf") do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match('Alias /static /home/django/repo/app/static') }
  its(:content) { should match('<Directory app/static>') }
  its(:content) { should match('<Directory app/account_site>') }
  # rubocop:disable Metrics/LineLength
  its(:content) { should match('WSGIDaemonProcess django python-path=/home/django/repo/app python-home=/home/django/env') }
  # rubocop:enable Metrics/LineLength
  its(:content) { should match('WSGIScriptAlias / /home/django/repo/app/account_site/wsgi\.py') }
end
