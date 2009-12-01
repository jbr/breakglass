class Family < ActiveRecord::Base
  require 'digest/sha1'
  
  attr_accessor :password
  validates_confirmation_of :password
  validates_presence_of :password, :if => :password_required?
  validates_length_of :password, :within => 4..40, :if => :password_required?
  validates_presence_of :name
  phone_field :external_contact_phone

  before_save :encrypt_password, :if => :password_required?
  after_create :create_meeting_places

  has_many :people, :dependent => :destroy
  has_many :meeting_places, :dependent => :destroy
  
  def encrypt_password
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--") if new_record?
    self.crypted_password = encrypt password.downcase
  end
  
  def authenticated?(password)
    crypted_password == encrypt(password.downcase)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  def create_meeting_places
    MeetingPlace::DEFAULTS.each do |mp_name|
      meeting_places.create! :name => mp_name
    end
  end
  
  private
  
  def encrypt(password)
    Digest::SHA1.hexdigest("--#{salt}--#{password.downcase}--")
  end
  
end
