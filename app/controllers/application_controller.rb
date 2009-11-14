class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  cattr_accessor :current_person
  helper_method :logged_in?, :current_person

  has_mobile_fu

  filter_parameter_logging :password, :password_confirmation
  
  def current_person
    @current_person ||= current_person_from_session
  end
  
  def current_person=(person)
    session[:person_id] = person.try :id
  end

  def logged_in?
    !!current_person
  end
  
  private
  def current_person_from_session
    return unless session[:person_id]
    Person.find_by_id session[:person_id]
  end
end
