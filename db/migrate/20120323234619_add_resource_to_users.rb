class AddResourceToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :resource, :boolean
  end

  def self.down
    remove_column :users, :resource
  end
end
