class AddCurrencyToProjectsPhasesJoins < ActiveRecord::Migration
  def self.up
    add_column :projects_phases_joins, :currency, :string
  end

  def self.down
    remove_column :projects_phases_joins, :currency
  end
end
