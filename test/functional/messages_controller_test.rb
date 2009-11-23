require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  context 'create' do
    context 'when not logged in' do
      setup { post_create }
      
      should 'redirect to log in url' do
        assert_redirected_to new_session_url
      end
      
      should 'not save a message' do
        assert_not_text @message_text, Message.last
      end
    end
    
    context 'when logged in' do
      setup do
        log_in_as :jacob
        flexmock(Message).new_instances.should_receive(:broadcast).once
        post_create
      end
      
      should 'set flash[:notice]' do
        assert_equal 'Message sent!', flash[:notice]
      end
      
      should 'save a message' do
        assert_text @message_text, Message.last
      end
    end
  end
  
  def post_create
    @message_text = "hello world"
    post :create, :message => { :text => @message_text }
  end
end
