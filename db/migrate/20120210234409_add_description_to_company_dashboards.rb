class AddDescriptionToCompanyDashboards < ActiveRecord::Migration
  def self.up
    add_column :company_dashboards, :description, :text
  end

  def self.down
    remove_column :company_dashboards, :description
  end
end
