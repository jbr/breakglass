class SmsHandler
  attr_reader :message, :connection
  
  def initialize(message)
    @connection = Clickatell::API.authenticate settings["api_id"],
      settings["username"], settings["password"]
    
    @message = message
  end
  
  def settings
    BREAKGLASS_SETTINGS['sms']
  end
  
  def contact(person)
    Rails.logger.info "Sending sms: #{message.text} to: #{person.sms}"
    connection.send_message "1#{person.sms}", message.text
  end
end