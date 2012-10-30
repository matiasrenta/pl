class CreateRiskStates < ActiveRecord::Migration
  def self.up
    create_table :risk_states do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_states
  end
end
