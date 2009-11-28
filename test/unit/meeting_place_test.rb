require 'test_helper'

class MeetingPlaceTest < ActiveSupport::TestCase
  context 'DEFAULTS' do
    should 'be correct' do
      assert_equal [
        'Neighborhood Meeting Place',
        'Regional Meeting Place',
        'Evacuation Location'
      ], MeetingPlace::DEFAULTS
    end
  end

  context 'with a meeting place' do
    setup {@meeting_place = MeetingPlace.new}
    
    context "phone-like-field phone" do
      context 'writer' do
        should 'strip nonnumeric characters' do
          @meeting_place.phone = "h3ll0"
          assert_phone "30", @meeting_place
        end
      end
      
      context 'with a valid phone' do
        setup {@meeting_place.phone = '0001112222'}
        should 'look like a phone number if the phone is set' do
          assert_formatted_phone '(000) 111-2222', @meeting_place
        end
        
        should 'be valid' do
          assert_valid @meeting_place
        end
      end
      
      context 'with an invalid phone' do
        setup {@meeting_place.phone = "111"}
        
        should 'not be valid' do
          assert_not_valid @meeting_place
        end
      end
      
      context 'with another record that has the same phone' do
        setup { @meeting_place.phone = MeetingPlace.first.phone }
        
        should 'not be valid' do
          assert_not_valid @meeting_place
        end
      end
      
      context 'formatted_phone' do
        should 'be blank if phone is not set' do
          assert_formatted_phone '', @meeting_place
        end

        should 'be valid' do
          assert_valid @meeting_place
        end
      end
    end
  end
end
