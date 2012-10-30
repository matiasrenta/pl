class AddPlannedResourcesCostToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :planned_resources_cost_cents, :integer
  end

  def self.down
    remove_column :projects, :planned_resources_cost_cents
  end
end
