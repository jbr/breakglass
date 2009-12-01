class Person < ActiveRecord::Base
  belongs_to :family
  has_many :family_members, :source => :people, :through => :family, :conditions => 'people.id <> #{id}'
  has_many :messages

  validates_presence_of :family
	validates_presence_of :phone
	
  phone_fields :sms, :phone
  
  def self.authenticate(phone, password)
    person = find_by_phone strip_nonnumeric(phone)
    if person && person.family.authenticated?(password)
      person
    else
      nil
    end
  end

end
