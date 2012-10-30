class CreateCompanyDashboards < ActiveRecord::Migration
  def self.up
    create_table :company_dashboards do |t|
      t.text :indicators
      t.text :costs
      t.text :accions_per_state
      t.text :open_accions_per_source

      t.timestamps
    end
  end

  def self.down
    drop_table :company_dashboards
  end
end
