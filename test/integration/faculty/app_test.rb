# frozen_string_literal: true

require_relative '../helpers'

describe file('/home/django/.ssh/known_hosts') do
  # Basics tested in default suite
  its(:content) { should match(/github\.com ssh-rsa/) }
end
