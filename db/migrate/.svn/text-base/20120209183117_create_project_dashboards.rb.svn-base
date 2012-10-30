class CreateProjectDashboards < ActiveRecord::Migration
  def self.up
    create_table :project_dashboards do |t|
      t.integer :project_id
      t.text :description
      t.text :phases_values
      t.text :project_values
      t.text :deviation_values
      t.text :risks
      t.text :accions
      t.text :problems
      t.text :present_users
      t.text :present_guest_users

      t.timestamps
    end
  end

  def self.down
    drop_table :project_dashboards
  end
end
