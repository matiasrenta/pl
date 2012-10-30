class CreateRisks < ActiveRecord::Migration
  def self.up
    create_table :risks do |t|
      t.string :name
      t.text :description
      t.date :detection_date
      t.string :umbral
      t.date :validity_from
      t.date :validity_to
      t.string :mitigation
      t.string :contingency
      t.integer :real_cost_cents
      t.string :currency
      t.integer :real_effort
      t.date :treatment_date
      t.string :manual_priority
      t.integer :project_id
      t.integer :risk_source_id
      t.integer :risk_category_id
      t.integer :risk_probability_id
      t.integer :risk_impact_id
      t.integer :risk_exposition_strategy_id
      t.integer :monitor_responsible_user_id
      t.integer :treatment_responsible_user_id
      t.integer :risk_state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :risks
  end
end
