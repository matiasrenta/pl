class AddRealEndDateToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :real_end_date, :date
  end

  def self.down
    remove_column :projects, :real_end_date
  end
end
