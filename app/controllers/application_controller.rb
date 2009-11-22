class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :logged_in?, :current_person, :current_family

  has_mobile_fu

  filter_parameter_logging :password, :password_confirmation
  
  def current_family
    current_person && current_person.family
  end
  
  def current_person
    @current_person ||= current_person_from_session
  end
  
  def current_person=(person)
    @current_person = nil
    session[:person_id] = person.try :id
  end
  
  def logged_in?
    !!current_person
  end
  
  def login_required
    unless logged_in?
      flash[:notice] = "Access denied, please log in."
      access_denied
    end
  end
  
  def access_denied
    redirect_to new_session_url and return false
  end
  
  private
  def current_person_from_session
    return unless session[:person_id]
    Person.find_by_id session[:person_id]
  end
end
