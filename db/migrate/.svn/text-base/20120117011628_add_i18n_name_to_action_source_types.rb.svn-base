class AddI18nNameToActionSourceTypes < ActiveRecord::Migration
  def self.up
    add_column :action_source_types, :i18n_name, :string
    remove_column :action_source_types, :name
  end

  def self.down
    remove_column :action_source_types, :i18n_name
    add_column :action_source_types, :name, :string
  end
end
