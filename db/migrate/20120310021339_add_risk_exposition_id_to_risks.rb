class AddRiskExpositionIdToRisks < ActiveRecord::Migration
  def self.up
    remove_column :risks, :risk_exposition_strategy_id
    add_column :risks, :risk_exposition_id, :integer
  end

  def self.down
    add_column :risks, :risk_exposition_strategy_id, :integer
    remove_column :risks, :risk_exposition_id
  end
end
