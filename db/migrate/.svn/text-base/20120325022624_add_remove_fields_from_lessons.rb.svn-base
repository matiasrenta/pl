class AddRemoveFieldsFromLessons < ActiveRecord::Migration
  def self.up
    remove_column :lessons, :projects_phases_joins_id
    add_column :lessons, :project_id, :integer
  end

  def self.down
    add_column :lessons, :projects_phases_joins_id, :integer
    remove_column :lessons, :project_id
  end
end
