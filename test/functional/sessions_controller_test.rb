require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  context 'new' do
    context 'when logged in' do
      setup do
        log_in_as :cameron
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
      
      context 'mobile' do
        setup do
          request.session[:mobile_view] = true
          get :new
        end
        
        should 'display the log in form' do
          assert_css 'form'
        end
      end
    end
  end
  
  context 'create (log in)' do
    setup do
      @person = people :cameron
      @person.family.update_attributes! :password => 'pass', :password_confirmation => 'pass'
    end
    
    context 'with a valid person phone and family password' do
      setup do
        post :create, :session => { :phone => @person.phone, :password => 'pass' }
      end
      
      should 'set the current_person' do
        assert_current_person @person, controller
      end
      
      should 'redirect to root_url' do
        assert_redirected_to root_url
      end
    end
    
    context 'without a valid person phone and family password pair' do
      setup do
        post :create, :session => { :phone => @person.phone, :password => 'something else' }
      end
      
      should 'not set the current_person' do
        assert_current_person nil, controller
      end
      
      should 'render the log in form' do
        assert_css "form[action='#{session_url}']"
      end
    end
  end
  
  context 'destroy (log out)' do
    context 'when not logged in' do
      setup {post :destroy}
      should 'redirect to log in' do
        assert_redirected_to new_session_url
      end
    end
    
    context 'when logged in' do
      setup do
        log_in_as people(:cameron)
        post :destroy
      end
      
      should 'set current person to nil' do
        assert_current_person nil, controller
      end
      
      should 'redirect to the log in url' do
        assert_redirected_to new_session_url
      end
    end
  end
end
