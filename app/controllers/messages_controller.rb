class MessagesController < ApplicationController

  def create
    # HACK HACK - need to actually make sure someone is logged in
    session[:person_id] = 1
    # end HACK HACK
    @message = Message.new(:text => params[:message][:text], :person_id => session[:person_id] )
    @message.save
    render :text => nil
  end

end
