class CreateProjectDashboardPresentUsersJoins < ActiveRecord::Migration
  def self.up
    create_table :project_dashboard_present_user_joins, :id => false do |t|
      t.integer :project_dashboard_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :project_dashboard_present_user_joins
  end
end
