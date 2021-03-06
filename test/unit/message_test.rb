require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  context 'message handler classes' do
    should 'register two handlers (hardcoded for now)' do
      assert_equal Set.new([SmsHandler, VoiceHandler]), Message.handler_classes
    end
  end
  
  context 'creating a new message' do
    setup {@message = Message.new :person => people(:cameron), :text => 'testing'}
    teardown {@message.save!}
    
    should 'create exactly one handler for each registered handler class' do
      Message.handler_classes.each do |handler_class|
        flexmock(handler_class).should_receive(:new).once.and_return flexmock(:contact => nil)
      end
    end
    
    should 'call contact once for each family member' do
      Message.handler_classes.each do |handler_class|
        handler = flexmock do |handler|
          handler.should_receive(:contact).and_return(nil).
            times @message.person.family_members.size
        end

        flexmock(handler_class).should_receive(:new).once.and_return handler
      end
    end
  end
end
