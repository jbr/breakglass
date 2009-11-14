class MessagesController < ApplicationController

  def create
    @message = Message.new(:text => params[:message][:text], :person_id => session[:person_id] )
    render :text => nil
  end

end
