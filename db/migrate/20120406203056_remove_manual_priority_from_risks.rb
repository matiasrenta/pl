class RemoveManualPriorityFromRisks < ActiveRecord::Migration
  def self.up
    remove_column :risks, :manual_priority
  end

  def self.down
    add_column :risks, :manual_priority, :string
  end
end
