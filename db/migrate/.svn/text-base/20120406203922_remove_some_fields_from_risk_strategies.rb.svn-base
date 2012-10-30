class RemoveSomeFieldsFromRiskStrategies < ActiveRecord::Migration
  def self.up
    remove_column :risk_strategies, :manual_priority_assignation
    remove_column :risk_strategies, :use_real_effort
  end

  def self.down
    add_column :risk_strategies, :manual_priority_assignation, :boolean
    add_column :risk_strategies, :use_real_effort, :boolean
  end
end
