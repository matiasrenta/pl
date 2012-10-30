class AddAddressFaxStateIdToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :address, :string
    add_column :companies, :fax, :string
    add_column :companies, :state_id, :integer
  end

  def self.down
    remove_column :companies, :address
    remove_column :companies, :fax
    remove_column :companies, :state_id
  end
end


