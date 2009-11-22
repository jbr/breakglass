require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  context 'new' do
    context 'when logged in' do
      setup do
        log_in_as people(:cameron)
        get :new
      end

      should "redirect to the root url" do
        assert_redirected_to root_url
      end
    end
    
    context 'when not logged in' do
      setup { get :new }

      should "display the log in form" do
        assert_css "form[action='#{session_url}'] input", 3
      end
      
      should 'display a log in button' do
        assert_css 'input[type=submit][value="Log In"]'
      end
    end
  end
end
