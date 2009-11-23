require 'test_helper'

class MeetingPlacesControllerTest < ActionController::TestCase
  context 'update' do
    context 'when not logged in' do
      setup { post_update_to :seattle_center }
      
      should 'redirect to log in' do
        assert_redirected_to new_session_url
      end
    end
    
    context 'when logged in' do
      setup { @person = log_in_as :cameron }
      
      context "when updating a meeting place affiliated with the person's family" do
        setup { post_update_to :seattle_center }
        
        should 'update the meeting place' do
          assert_text 'updated', @meeting_place
        end
        
        should 'replace the correct meeting place (jQuery)' do
          assert_match "$('##{@meeting_place.element_id}').replaceWith(", response.body
        end
      end
      
      context 'when attempting to update a meeting place affiliated with another family' do
        setup { post_update_to :san_pablo_park }
        
        should 'not update the meeting place' do
          assert_not_text 'updated', @meeting_place
        end
        
        should 'redirect to the current family url' do
          assert_redirected_to family_url(@person.family)
        end
      end
    end
  end
  
  def post_update_to(meeting_place)
    meeting_place = meeting_places meeting_place if meeting_place.is_a? Symbol
    post :update, :id => meeting_place.to_param, :meeting_place => { :text => 'updated' }
    @meeting_place = meeting_place.reload
  end
end
