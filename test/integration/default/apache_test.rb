# frozen_string_literal: true

require_relative '../helpers'

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe file(path_to_vhost(node)) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match('Include conf-available/django-host\.conf') }
end

describe file(path_to_http_host(node)) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match('Header always set Referrer-Policy "strict-origin"') }
  # its(:content) { should match('DocumentRoot /home/django/repo/app') }
end

describe bash('apachectl -M') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match 'alias_module' }
end

describe package(apache_dev_package_name(node)) do
  it { should be_installed }
  its(:version) { should match(/^2\.4/) }
end

describe file(path_to_django_host(node)) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match('Alias /static /home/django/repo/static') }
  # its(:content) { should match(%r{<Directory static>\s+Require all granted}) }
end

describe file(path_to_django_conf(node)) do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  # rubocop:disable Metrics/LineLength
  its(:content) { should match("WSGIDaemonProcess django python-home=#{path_to_python_env} python-path=/home/django/repo/app") }
  # rubocop:enable Metrics/LineLength
  its(:content) { should match('WSGISocketPrefix /var/run/apache2/wsgi') } if node['platform_family'] == 'debian'
  its(:content) { should match('WSGISocketPrefix /var/run/wsgi') } unless node['platform_family'] == 'debian'
end

describe file(path_to_django_conf_link(node)) do
  it { should exist }
  it { should be_symlink }
  it { should be_mode 0o440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:link_path) { should eq path_to_django_conf(node) }
end

# Make sure the end result is a working server

describe service(apache_service(node)) do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe bash('apachectl configtest') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should match 'Syntax OK' } # Yep, output is on stderr
  its(:stdout) { should eq '' }
end

pages = [
  {
    page: '',
    status: 200,
    content: /doctype html/i
  },
  {
    page: '/admin',
    status: 301,
    content: ''
  }
]

pages.each do |page|
  describe http("https://localhost#{page[:page]}", ssl_verify: false) do
    its(:status) { should cmp page[:status] }
    its(:body) { should match(page[:content]) }
  end
end
