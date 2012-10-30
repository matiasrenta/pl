class AddI18nNameToProblemSeverities < ActiveRecord::Migration
  def self.up
    add_column :problem_severities, :i18n_name, :string
    remove_column :problem_severities, :name
  end

  def self.down
    remove_column :problem_severities, :i18n_name
    add_column :problem_severities, :name, :string
  end
end
