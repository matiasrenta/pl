class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.date :planned_start_date
      t.date :real_start_date
      t.date :planned_end_date
      t.date :real_end_date
      t.integer :planned_duration
      t.integer :real_duration
      t.integer :planned_hours
      t.integer :real_hours
      t.integer :planned_progress
      t.integer :real_progress
      t.integer :planned_cost_cents
      t.integer :real_cost_cents
      t.string :currency
      t.boolean :no_consecutive_task
      t.boolean :no_previous_task
      t.integer :life_cycle_id
      t.integer :life_cycle_phase_id
      t.integer :task_state_id
      t.integer :project_id
      t.integer :task_type_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
