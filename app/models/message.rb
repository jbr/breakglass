require 'set'
class Message < ActiveRecord::Base
  cattr_reader :handler_classes
  belongs_to :person
  validates_presence_of :person
  after_create :broadcast

  @@handler_classes = Set.new << SmsHandler << VoiceHandler

  private
  
  def broadcast
    Message.handler_classes.each do |handler_class|
      handler = handler_class.new self
      person.family_members.each {|person| handler.contact person}
    end
  end
end
