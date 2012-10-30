class CreateRiskStrategyRiskCategoryJoin < ActiveRecord::Migration
  def self.up
    create_table :risk_strategy_risk_category_joins, :id => false do |t|
      t.integer :risk_strategy_id
      t.integer :risk_category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :risk_strategy_risk_category_joins
  end
end

