class SessionsController < ApplicationController
  before_filter :login_required, :only => :destroy
  
  def new
		redirect_to '/' if logged_in?
  end

  def create
    self.current_person = Person.authenticate params[:session][:phone], params[:session][:password]
    
    if logged_in?
      flash[:notice] = "Logged in!"
      redirect_to '/'
    else
      flash[:error] = "Could not log in"
      render :action => 'new'
    end
  end

  def destroy
    self.current_person = nil
    reset_session
    redirect_to new_session_url
  end
end
