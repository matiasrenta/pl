class RemoveIsExternalFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :is_external
  end

  def self.down
    add_column :users, :is_external, :boolean
  end
end
