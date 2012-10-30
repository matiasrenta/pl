class CreateProblems < ActiveRecord::Migration
  def self.up
    create_table :problems do |t|
      t.string :name
      t.text :description
      t.integer :project_id
      t.integer :user_id
      t.integer :treatment_user_id
      t.integer :problem_severity_id
      t.integer :problem_priority_id
      t.integer :problem_state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :problems
  end
end
