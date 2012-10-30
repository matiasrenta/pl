class AddCapacityOccupancyToCompanyDashboards < ActiveRecord::Migration
  def self.up
    add_column :company_dashboards, :capacity, :integer
    add_column :company_dashboards, :occupancy, :integer
  end

  def self.down
    remove_column :company_dashboards, :capacity
    remove_column :company_dashboards, :occupancy
  end
end
