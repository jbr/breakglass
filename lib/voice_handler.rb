class VoiceHandler
  attr_reader :message
    
  def initialize(message)
    Twilio.connect settings["account_sid"], settings["auth_token"]
    @message = message
  end
  
  def settings
    BREAKGLASS_SETTINGS['voice']
  end
  
  def contact(person)
    Rails.logger.info "Voice calling: #{person.phone} and telling them: #{message.text}"
    Twilio::Call.make settings["caller_id"], person.phone, callback
  end
  
  def callback
    settings["callback"].gsub "%m", CGI.escape(message.text)
  end
end