class AddExternalContactPhoneToFamily < ActiveRecord::Migration
  def self.up
    add_column :families, :external_contact_phone, :string, :limit => 32
  end

  def self.down
    remove_column :families, :external_contact_phone
  end
end
