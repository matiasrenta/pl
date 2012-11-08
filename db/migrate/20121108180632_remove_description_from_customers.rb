class RemoveDescriptionFromCustomers < ActiveRecord::Migration
  def self.up
    remove_column :customers, :description
  end

  def self.down
    add_column :customers, :description, :text
  end
end
