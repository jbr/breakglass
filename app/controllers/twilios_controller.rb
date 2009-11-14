class TwiliosController < ApplicationController
  def show
    render :xml => Twilio::Verb.say(params[:msg], :loop => 3, :pause => true)
  end
end
