class CreateProjectsUsersJoins < ActiveRecord::Migration
  def self.up
    create_table :projects_users_joins do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :hour_cost_in_project_cents
      t.string :currency
      t.text :responsibility

      t.timestamps
    end
  end

  def self.down
    drop_table :projects_users_joins
  end
end
