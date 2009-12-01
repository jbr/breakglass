class MeetingPlace < ActiveRecord::Base
  belongs_to :family
  acts_as_list :scope => :family
  phone_field :phone
  
  DEFAULTS = [
    'Neighborhood Meeting Place',
    'Regional Meeting Place',
    'Evacuation Location'
  ]
  
end
