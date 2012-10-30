class RemoveResponsiblesFromProblems < ActiveRecord::Migration
  def self.up
    remove_column :problems, :treatment_user_id
    remove_column :problems, :monitor_user_id

    add_column :problems, :responsible_user_id, :integer
  end

  def self.down
  end
end
