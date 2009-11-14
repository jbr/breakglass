class Family < ActiveRecord::Base

  require 'digest/sha1'

  attr_accessor :password
  validates_confirmation_of :password
  validates_presence_of :password, :if => :password_required?
  before_save :encrypt_password, :if => :password_required?
  after_create :create_meeting_places
  
  validates_presence_of     :password,                   :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  
  validates_presence_of :name
	
  has_many :people
  has_many :meeting_places
  
  def encrypt_password
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--") if new_record?
    self.crypted_password = encrypt password.downcase
  end
  
  def encrypt(password)
    Digest::SHA1.hexdigest("--#{salt}--#{password.downcase}--")
  end
  
  def authenticated?(password)
    crypted_password == encrypt(password.downcase)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end

  def create_meeting_places
    logger.debug ("Here")
    meeting_place_names = ['Neighborhood Meeting Place', 'Regional Meeting Place', 'Evacuation Location']
    meeting_place_names.each do |mp_name|
      mp = self.meeting_places.new(:name => mp_name)
      mp.save
    end
  end
end
