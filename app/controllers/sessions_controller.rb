class SessionsController < ApplicationController
  before_filter :login_required, :only => :destroy
  
  def new
    if logged_in?
      redirect_to root_url
    else
      render :template => 'sessions/new.html', :format => 'html'
    end
  end

  def create
    self.current_person = Person.authenticate params[:session][:phone], params[:session][:password]

    if logged_in?
      flash[:notice] = "Logged in!"
      redirect_to root_url
    else
      flash[:error] = "Could not log in"
      render :template => 'sessions/new.html'
    end
  end

  def destroy
    self.current_person = nil
    reset_session
    redirect_to new_session_url
  end
end
