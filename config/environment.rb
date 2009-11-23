RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "twilio", :source => "http://gemcutter.org"
  config.gem "clickatell"
  config.time_zone = 'UTC'
end
