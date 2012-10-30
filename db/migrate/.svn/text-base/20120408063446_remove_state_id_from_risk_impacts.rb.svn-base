class RemoveStateIdFromRiskImpacts < ActiveRecord::Migration
  def self.up
    remove_column :risk_impacts, :state_id
  end

  def self.down
    add_column :risk_impacts, :state_id, :integer
  end
end
