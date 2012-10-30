class CreateRiskExpositionStrategies < ActiveRecord::Migration
  def self.up
    create_table :risk_exposition_strategies do |t|
      t.integer :risk_probability_id
      t.integer :risk_impact_id
      t.integer :risk_exposition_id
      t.string :color

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_exposition_strategies
  end
end
