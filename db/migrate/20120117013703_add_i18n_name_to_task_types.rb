class AddI18nNameToTaskTypes < ActiveRecord::Migration
  def self.up
    add_column :task_types, :i18n_name, :string
    remove_column :task_types, :name
  end

  def self.down
    remove_column :task_types, :i18n_name
    add_column :task_types, :name, :string
  end
end
