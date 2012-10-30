class CreateTaskProgresses < ActiveRecord::Migration
  def self.up
    create_table :task_progresses do |t|
      t.text :description
      t.integer :effort
      t.integer :progress
      t.date :working_day
      t.integer :task_id

      t.timestamps
    end
  end

  def self.down
    drop_table :task_progresses
  end
end
