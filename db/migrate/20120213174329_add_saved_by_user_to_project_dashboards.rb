class AddSavedByUserToProjectDashboards < ActiveRecord::Migration
  def self.up
    add_column :project_dashboards, :saved_by_user, :boolean
  end

  def self.down
    remove_column :project_dashboards, :saved_by_user
  end
end
