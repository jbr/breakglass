class AddExternalContactNameToFamily < ActiveRecord::Migration
  def self.up
    add_column :families, :external_contact_name, :string, :limit => 64
  end

  def self.down
    remove_column :families, :external_contact_name
  end
end
