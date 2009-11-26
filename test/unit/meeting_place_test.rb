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
end
