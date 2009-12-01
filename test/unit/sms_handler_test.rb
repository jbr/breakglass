require 'test_helper'

class SmsHandlerTest < ActiveSupport::TestCase
  context 'with test settings' do
    setup do
      @settings = BREAKGLASS_SETTINGS['sms'] = {
        'api_id' => 'my id',
        'username' => 'username',
        'password' => 'password'
      }
      
      @message = messages :hello_world
      @person = people :lara
    end
    
    context 'initialization' do
      should 'authenticate with clickatell' do
        flexmock(Clickatell::API).should_receive(:authenticate).once.
          with @settings['api_id'], @settings['username'], @settings['password']
        SmsHandler.new @message
      end
    end
    
    context 'with a handler' do
      setup do
        flexmock(Clickatell::API).should_receive(:authenticate).
          and_return(@connection = :connection)
        @handler = SmsHandler.new @message
      end
      
      should 'have the right message' do
        assert_message @message, @handler
      end
      
      should 'have the right connection' do
        assert_connection @connection, @handler
      end
    end
    
    context 'contact' do
      should 'contact clickatell with the right number and text' do
        @connection = flexmock do |conn|
          conn.should_receive(:send_message).once.
            with "1#{@person.sms}", @message.text
        end
        
        flexmock(Clickatell::API).should_receive(:authenticate).
          and_return(@connection)
          
        SmsHandler.new(@message).contact @person
      end
    end
  end
end
