class AddAndRemoveSomeFieldsToTasks < ActiveRecord::Migration
  def self.up
    remove_columns :tasks, [:no_consecutive_task, :no_previous_task]
    add_column :tasks, :parent_id, :integer
  end

  def self.down
    add_column :tasks, :no_consecutive_task, :boolean
    add_column :tasks, :no_previous_task, :boolean
    remove_column :tasks, :parent_id
  end
end
