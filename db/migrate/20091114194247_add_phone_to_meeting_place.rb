class AddPhoneToMeetingPlace < ActiveRecord::Migration
  def self.up
    add_column :meeting_places, :phone, :string, :limit => 10
  end

  def self.down
    remove_column :meeting_places, :phone
  end
end
