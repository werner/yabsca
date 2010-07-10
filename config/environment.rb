# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "authlogic", :version => '2.1.5'
  config.time_zone = 'UTC'
end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y')
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y %H:%M')

require "will_paginate"

module Frecuency
  Daily=1
  Weekly=2
  Monthly=3
  Bimonthly=4
  Three_monthly=5
  Four_monthly=6
  Yearly=7
end

module Challenge
  Increasing=1
  Decreasing=2
end

module SubSystem
  Organization=1
  Strategy=2
  Perspective=3
  Objective=4
  Measure=5
end

module Rule
  Create=1
  Read=2
  Update=3
  Delete=4
end