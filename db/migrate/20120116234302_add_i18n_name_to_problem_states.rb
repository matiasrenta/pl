class AddI18nNameToProblemStates < ActiveRecord::Migration
  def self.up
    add_column :problem_states, :i18n_name, :string
    remove_column :problem_states, :name
  end

  def self.down
    remove_column :problem_states, :i18n_name
    add_column :problem_states, :name, :string
  end
end
