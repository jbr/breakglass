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
    should_have_phone_like_field :phone
  end
end
