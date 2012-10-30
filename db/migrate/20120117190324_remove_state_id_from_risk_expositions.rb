class RemoveStateIdFromRiskExpositions < ActiveRecord::Migration
  def self.up
    remove_column :risk_expositions, :state_id
  end

  def self.down
    add_column :risk_expositions, :state_id, :integer
  end
end
