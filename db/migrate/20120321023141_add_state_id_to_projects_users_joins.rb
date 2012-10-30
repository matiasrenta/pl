class AddStateIdToProjectsUsersJoins < ActiveRecord::Migration
  def self.up
    add_column :projects_users_joins, :state_id, :integer
  end

  def self.down
    remove_column :projects_users_joins, :state_id
  end
end
