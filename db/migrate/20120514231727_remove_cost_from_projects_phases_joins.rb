class RemoveCostFromProjectsPhasesJoins < ActiveRecord::Migration
  def self.up
    remove_column :projects_phases_joins, :currency
    remove_column :projects_phases_joins, :planned_cost_phase_cents
  end

  def self.down
    add_column :projects_phases_joins, :currency, :string
    add_column :projects_phases_joins, :planned_cost_phase_cents, :integer
  end
end
