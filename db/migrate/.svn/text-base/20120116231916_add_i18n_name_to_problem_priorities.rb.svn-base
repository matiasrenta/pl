class AddI18nNameToProblemPriorities < ActiveRecord::Migration
  def self.up
    add_column :problem_priorities, :i18n_name, :string
    remove_column :problem_priorities, :name
  end

  def self.down
    remove_column :problem_priorities, :i18n_name
    add_column :problem_priorities, :name, :string
  end
end
