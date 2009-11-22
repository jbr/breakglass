require 'test_helper'

class FamiliesControllerTest < ActionController::TestCase
  context 'index' do
    context 'when logged in' do
      setup do
        @person = log_in_as :cameron
        get :index
      end
      
      should 'render the show action for the current family' do
        assert_css ".family##{@person.family.element_id}"
      end
    end
    
    context 'when not logged in' do
      setup {get :index}
      should 'redirect to log in url' do
        assert_redirected_to new_session_url
      end
    end
  end
end
