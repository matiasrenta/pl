class AddLiderToProjectUserJoins < ActiveRecord::Migration
  def self.up
    add_column :projects_users_joins, :leader, :boolean
  end

  def self.down
    remove_column :projects_users_joins, :leader
  end
end
