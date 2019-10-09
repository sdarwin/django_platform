# frozen_string_literal: true

require_relative '../helpers'

describe pip('django-widget-tweaks', path_to_pip) do
  it { should be_installed }
end

describe pip('Markdown', path_to_pip) do
  it { should be_installed }
end
