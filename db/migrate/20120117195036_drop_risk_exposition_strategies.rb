class DropRiskExpositionStrategies < ActiveRecord::Migration
  def self.up
    drop_table :risk_exposition_strategies
  end

  def self.down
    create_table :risk_exposition_strategies do |t|
      t.integer :risk_probability_id
      t.integer :risk_impact_id
      t.integer :risk_exposition_id
      t.string :color

      t.timestamps
    end
  end
end
