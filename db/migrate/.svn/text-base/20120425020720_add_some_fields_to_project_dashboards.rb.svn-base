class AddSomeFieldsToProjectDashboards < ActiveRecord::Migration
  def self.up
    remove_column :project_dashboards, :saved_by_user
    add_column :project_dashboards, :user_id, :integer
    add_column :project_dashboards, :status_report, :boolean
  end

  def self.down
  end
end
