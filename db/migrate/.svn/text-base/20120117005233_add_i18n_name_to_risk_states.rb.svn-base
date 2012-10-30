class AddI18nNameToRiskStates < ActiveRecord::Migration
  def self.up
    add_column :risk_states, :i18n_name, :string
    remove_column :risk_states, :name
  end

  def self.down
    remove_column :risk_states, :i18n_name
    add_column :risk_states, :name, :string
  end
end
