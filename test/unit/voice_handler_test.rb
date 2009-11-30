require 'test_helper'

class VoiceHandlerTest < ActiveSupport::TestCase
  context 'with test settings' do
    setup do
      @settings = BREAKGLASS_SETTINGS['voice'] = {
        'account_sid' => 'sid',
        'auth_token' => 'token',
        'callback' => 'something=%m',
        'caller_id' => 'cid'
      }
    end
    
    context 'initialization' do
      setup {@message = messages :hello_world}
      should 'call Twilio.connect' do
        flexmock(Twilio).should_receive(:connect).once.
          with @settings['account_sid'], @settings['auth_token']

        VoiceHandler.new @message
      end
    end
  
    context 'with a handler' do
      setup do
        @message = messages :hello_world
        flexmock(Twilio).should_receive :connect
        @handler = VoiceHandler.new @message
      end
    
      should 'set the message' do
        assert_message @message, @handler
      end
    
      should 'have the right callback' do
        assert_callback "something=#{CGI::escape @message.text}", @handler
      end
      
      context 'contact' do
        should 'make a twilio call' do
          person = people :lara
          flexmock(Twilio::Call).should_receive(:make).once.
            with @settings['caller_id'], person.phone, @handler.callback
          
          @handler.contact person
        end
      end
    end
  end
end
