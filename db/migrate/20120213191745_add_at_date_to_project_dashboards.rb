class AddAtDateToProjectDashboards < ActiveRecord::Migration
  def self.up
    add_column :project_dashboards, :at_date, :date
  end

  def self.down
    remove_column :project_dashboards, :at_date
  end
end
