ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'test_rig'
require 'shoulda'

class ActiveSupport::TestCase
  include TestRig

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end
