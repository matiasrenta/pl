class CreateRiskStrategies < ActiveRecord::Migration
  def self.up
    create_table :risk_strategies do |t|
      t.string :name
      t.text :description
      t.boolean :manual_priority_assignation
      t.boolean :use_umbral
      t.boolean :use_validity
      t.boolean :use_real_cost
      t.boolean :use_real_effort
      t.integer :user_id
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_strategies
  end
end

