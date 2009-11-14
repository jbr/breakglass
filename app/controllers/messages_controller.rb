class MessagesController < ApplicationController
  before_filter :login_required

  def create
    @message = Message.new(:text => params[:message][:text], :person_id => session[:person_id] )
    @message.save
    redirect_to current_person.family
  end

end
