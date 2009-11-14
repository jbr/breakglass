class Message < ActiveRecord::Base
	belongs_to :person

	validates_presence_of :person

	after_create :broadcast

	private

	def broadcast
		# TODO: async creation of twilio/clickatel notifications here the recipient
		# list will be self.person.family.people
	end

end
