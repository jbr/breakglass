require 'test_helper'

class TwiliosControllerTest < ActionController::TestCase
  context 'create' do
    context 'when logged in' do
      setup do
        @current_person = log_in_as :jacob
        
        flexmock(Twilio::Verb).should_receive(:say).once.
          with(*expected_arguments).and_return("some xml")

        post_create
      end
      
      should 'render some xml' do
        assert_body "some xml", response
      end
      
      should 'set the content type' do
        assert_content_type 'application/xml', response
      end
    end
    
    context 'when not logged in' do
      setup { post_create }
      
      should 'redirect to log in' do
        assert_redirected_to new_session_url
      end
    end
  end
  
  private
  def expected_arguments
    ["Howdy world", {:loop => 3, :pause => true}]
  end
  
  def post_create
    post :create, :msg => 'Howdy world'
  end
end
