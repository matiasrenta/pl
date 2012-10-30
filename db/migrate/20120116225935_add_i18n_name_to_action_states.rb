class AddI18nNameToActionStates < ActiveRecord::Migration
  def self.up
    add_column :action_states, :i18n_name, :string
    remove_column :action_states, :name
  end

  def self.down
    remove_column :action_states, :i18n_name
    add_column :action_states, :name, :string
  end
end
