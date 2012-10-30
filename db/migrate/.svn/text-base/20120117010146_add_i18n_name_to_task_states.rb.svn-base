class AddI18nNameToTaskStates < ActiveRecord::Migration
  def self.up
    add_column :task_states, :i18n_name, :string
    remove_column :task_states, :name
  end

  def self.down
    remove_column :task_states, :i18n_name
    add_column :task_states, :name, :string
  end
end
