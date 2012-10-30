class RemoveDatesFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :planned_start_date
    remove_column :projects, :planned_end_date
  end

  def self.down
    add_column :projects, :planned_start_date, :date
    add_column :projects, :planned_end_date, :date
  end
end
