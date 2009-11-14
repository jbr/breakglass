class MessagesController < ApplicationController
  before_filter :login_required

  def create
    @message = current_person.messages.build params[:message]
    @success = @message.save
    redirect_to current_person.family
  end

end
