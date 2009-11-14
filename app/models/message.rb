class Message < ActiveRecord::Base
	belongs_to :person

	validates_presence_of :person

	after_create :broadcast

	private

	def broadcast
		# TODO: fill this in
	end

end
