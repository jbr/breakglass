class CreateMeetingPlaces < ActiveRecord::Migration
  def self.up
    create_table :meeting_places do |t|
      t.integer :family_id
      t.integer :position
      t.string :name, :limit => 64
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :meeting_places
  end
end
