class TwiliosController < ApplicationController
  before_filter :login_required
  
  def show
    render :xml => Twilio::Verb.say(params[:msg], :loop => 3, :pause => true)
  end

  def create
    render :xml => Twilio::Verb.say(params[:msg], :loop => 3, :pause => true)
  end
end
