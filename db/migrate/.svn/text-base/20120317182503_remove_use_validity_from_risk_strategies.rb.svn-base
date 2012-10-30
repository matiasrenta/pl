class RemoveUseValidityFromRiskStrategies < ActiveRecord::Migration
  def self.up
    remove_column :risk_strategies, :use_validity
  end

  def self.down
    add_column :risk_strategies, :use_validity, :boolean
  end
end
