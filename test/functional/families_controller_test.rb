require 'test_helper'

class FamiliesControllerTest < ActionController::TestCase
  context 'index' do
    context 'when logged in' do
      setup { @person = log_in_as :cameron }
      
      context 'normal browser view' do
        setup { get :index }

        should 'render the show action for the current family' do
          assert_showing_family @person.family
        end
      end

      context 'mobile view' do
        setup do
          request.session[:mobile_view] = true
          get :index
        end
      
        should 'say who is logged in' do
          assert_match /Logged in as #{@person.name}/, response.body
        end
      
        should 'show the log out link' do
          assert_css '#log-out'
        end
      end
    end
    
    context 'when not logged in' do
      setup { get :index }
      should 'redirect to log in url' do
        assert_redirected_to new_session_url
      end
    end
  end
  
  context 'show' do
    context 'when logged in' do
      setup { @person = log_in_as :cameron }

      context 'when viewing another family' do
        setup { get :show, :id => families(:rothstein).to_param }
      
        should 'redirect to the current family' do
          assert_redirected_to family_url(@person.family)
        end
      end
      
      context 'when viewing the correct family' do
        setup { get :show, :id => @person.family.to_param }
        
        should 'show the family' do
          assert_showing_family @person.family
        end
      end
    end
  end
  
  context 'update' do
    context 'when logged in' do
      setup { @person = log_in_as :cameron }
      context 'when updating another family' do
        setup do
          post :update, :id => families(:rothstein).to_param, :family => { :name => 'mud' }
        end
        
        should 'redirect to the current family (for now)' do
          assert_redirected_to family_url(@person.family)
        end
        
        should 'not update the family' do
          assert_not_name 'mud', families(:rothstein)
        end
      end
      
      context 'when updating the correct family' do
        setup do
          post :update, :id => @person.family.to_param, :family => { :name => 'updated' }
        end
        
        should 'update the family correctly' do
          assert_name 'updated', @person.family.reload
        end
        
        should 'redirect to show the family' do
          assert_redirected_to family_url(@person.family)
        end
      end
    end
  end
  
  def assert_showing_family(family)
    assert_css ".family##{family.element_id}"
  end
end
