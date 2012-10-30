class CreateRiskStrategyRiskSourceJoin < ActiveRecord::Migration
  def self.up
    create_table :risk_strategy_risk_source_joins, :id => false do |t|
      t.integer :risk_strategy_id
      t.integer :risk_source_id
      t.timestamps
    end
  end

  def self.down
    drop_table :risk_strategy_risk_source_joins
  end
end
