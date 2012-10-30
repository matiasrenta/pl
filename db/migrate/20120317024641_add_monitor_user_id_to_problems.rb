class AddMonitorUserIdToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :monitor_user_id, :integer
  end

  def self.down
    remove_column :problems, :monitor_user_id
  end
end
