class MeetingPlace < ActiveRecord::Base
  extend Phone::Methods
  acts_as_list :scope => :family
  phone_like_field :phone

  def new
  end
end
