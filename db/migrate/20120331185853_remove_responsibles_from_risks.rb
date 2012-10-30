class RemoveResponsiblesFromRisks < ActiveRecord::Migration
  def self.up
    remove_column :risks, :monitor_responsible_user_id
    remove_column :risks, :treatment_responsible_user_id

    add_column :risks, :responsible_user_id, :integer
  end

  def self.down
  end
end
