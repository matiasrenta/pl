class CreateRiskSources < ActiveRecord::Migration
  def self.up
    create_table :risk_sources do |t|
      t.string :name
      t.text :description
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_sources
  end
end
