class AddRemoveSomeFieldsFromRisks < ActiveRecord::Migration
  def self.up
    remove_column :risks, :risk_category_id
    add_column :risks, :life_cycle_phase_id, :integer
  end

  def self.down
    add_column :risks, :risk_category_id, :integer
    remove_column :risks, :life_cycle_phase_id
  end
end
