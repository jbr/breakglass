class TwiliosController < ApplicationController
  def show
    random_code = params[:pin].gsub(/\d/) {|s| s + ' '}
    render :xml => Twilio::Verb.say("Your pin code is #{random_code}", 
          :loop => 3, :pause => true)
  end
end
