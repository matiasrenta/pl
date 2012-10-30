class CreateCustomersProjectsJoins < ActiveRecord::Migration
  def self.up
    create_table :customers_projects_joins, :id => false do |t|
      t.integer :project_id
      t.integer :user_id
      t.timestamps
  end

  def self.down
    drop_table :customers_projects_joins
  end
  end
end
