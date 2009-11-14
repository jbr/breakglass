class MessagesController < ApplicationController
  before_filter :login_required

  def create
    @message = Message.new(:text => params[:message][:text], :person_id => session[:person_id] )
    @message.save
    render :text => nil
  end

end
