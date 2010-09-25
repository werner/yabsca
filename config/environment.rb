# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "authlogic", :version => "2.1.6"
#  config.gem "haml", :version => "3.0.17"
#  config.gem "sqlite3-ruby", :version => "1.3.1"
#  config.gem "treetop", :version => "1.4.8"
#  config.gem "spreadsheet", :version => "0.6.4.1"
  
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  #config.i18n.default_locale = :es

end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y')
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y %H:%M')

require "tempfile"

module Frecuency
  Daily=1
  Weekly=6
  Monthly=5
  Bimonthly=2
  Three_monthly=3
  Four_monthly=4
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
