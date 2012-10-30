class RemoveCodeFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :code
  end

  def self.down
    add_column :projects, :code, :string
  end
end
