class CreateAccions < ActiveRecord::Migration
  def self.up
    create_table :accions do |t|
      t.string :title
      t.text :description
      t.date :commitment_date
      t.date :real_date
      t.integer :user_id
      t.integer :responsible_user_id
      t.integer :project_problem_id
      t.integer :action_source_type_id
      t.integer :action_state_id
      t.integer :action_priority_id
      t.integer :project_id
      t.integer :project_risk_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accions
  end
end

