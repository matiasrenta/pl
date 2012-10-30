class AddStateIdToCountry < ActiveRecord::Migration
  def self.up
    add_column :countries, :state_id, :integer
  end

  def self.down
    remove_column :countries, :state_id
  end
end

