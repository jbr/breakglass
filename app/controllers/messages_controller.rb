class MessagesController < ApplicationController

  def new
		@message = Message.new(params)
  end

end
