class AddI18nNameToActionPriorities < ActiveRecord::Migration
  def self.up
    add_column :action_priorities, :i18n_name, :string
    remove_column :action_priorities, :name
  end

  def self.down
    remove_column :action_priorities, :i18n_name
    add_column :action_priorities, :name, :string
  end
end

