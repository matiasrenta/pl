class RemoveStateIdFromLifeCyclePhases < ActiveRecord::Migration
  def self.up
    remove_column :life_cycle_phases, :state_id
  end

  def self.down
    add_column :life_cycle_phases, :state_id, :integer
  end
end
