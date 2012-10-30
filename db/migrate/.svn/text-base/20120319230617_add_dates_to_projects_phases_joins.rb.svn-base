class AddDatesToProjectsPhasesJoins < ActiveRecord::Migration
  def self.up
    add_column :projects_phases_joins, :planned_start_date, :date
    add_column :projects_phases_joins, :planned_end_date, :date
  end

  def self.down
    remove_column :projects_phases_joins, :planned_start_date
    remove_column :projects_phases_joins, :planned_end_date
  end
end
