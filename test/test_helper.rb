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


class ActionController::TestCase
  attr_reader :request, :response
  def log_in_as(person)
    request.session[:person_id] = person.id
  end
  
  def log_out
    request.session[:person_id] = nil
  end
end