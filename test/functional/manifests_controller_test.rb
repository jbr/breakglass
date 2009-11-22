require 'test_helper'

class ManifestsControllerTest < ActionController::TestCase
  context 'index' do
    context 'when not logged in' do
      setup { get :index }
      should('head 404') { assert_response 404 }
    end
    
    context 'when logged in' do
      setup do
        log_in_as people(:cameron)
        get :index
      end
      
      should 'render a manifest' do
        assert_match "CACHE MANIFEST", response.body
      end
    end
  end
end
