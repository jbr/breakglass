class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer :family_id
      t.string :name, :limit => 64
      t.string :phone, :limit => 32
      t.string :sms, :limit => 32
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
