class RemoveRealEffortFromRisks < ActiveRecord::Migration
  def self.up
    remove_column :risks, :real_effort
  end

  def self.down
    add_column :risks, :real_effort, :integer
  end
end
