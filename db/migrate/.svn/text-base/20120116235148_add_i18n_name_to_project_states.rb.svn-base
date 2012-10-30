class AddI18nNameToProjectStates < ActiveRecord::Migration
  def self.up
    add_column :project_states, :i18n_name, :string
    remove_column :project_states, :name
  end

  def self.down
    remove_column :project_states, :i18n_name
    add_column :project_states, :name, :string
  end
end
