class RemoveStateIdFromRiskProbabilities < ActiveRecord::Migration
  def self.up
    remove_column :risk_probabilities, :state_id
  end

  def self.down
    add_column :risk_probabilities, :state_id, :integer
  end
end
