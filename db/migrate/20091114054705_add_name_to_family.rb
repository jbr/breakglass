class AddNameToFamily < ActiveRecord::Migration
  def self.up
    add_column :families, :name, :string
  end

  def self.down
    remove_column :families, :name
  end
end
