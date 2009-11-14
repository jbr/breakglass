class Person < ActiveRecord::Base
	belongs_to :family
	has_many :messages

	validates_presence_of :family
end
