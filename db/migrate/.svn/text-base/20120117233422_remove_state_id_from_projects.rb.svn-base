class RemoveStateIdFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :state_id
  end

  def self.down
    add_column :projects, :state_id, :integer
  end
end
