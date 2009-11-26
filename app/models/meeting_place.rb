class MeetingPlace < ActiveRecord::Base
  extend Phone::Methods
  belongs_to :family
  acts_as_list :scope => :family
  phone_like_field :phone
  
  DEFAULTS = [
    'Neighborhood Meeting Place',
    'Regional Meeting Place',
    'Evacuation Location'
  ]
  
end
