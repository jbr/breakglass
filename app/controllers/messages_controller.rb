class MessagesController < ApplicationController
  before_filter :login_required

  def create
    @message = current_person.messages.build params[:message]
    
    if @success = @message.save
      flash[:notice] = "Message sent!"
    else
      flash[:error] = "Message not sent."
    end
    
    redirect_to current_family
  end

end
