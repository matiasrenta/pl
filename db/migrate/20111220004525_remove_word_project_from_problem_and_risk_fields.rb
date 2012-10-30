class RemoveWordProjectFromProblemAndRiskFields < ActiveRecord::Migration
  def self.up
    remove_column :accions, :project_problem_id
    remove_column :accions, :project_risk_id
    add_column :accions, :problem_id, :integer
    add_column :accions, :risk_id, :integer
  end

  def self.down
    add_column :accions, :project_problem_id, :integer
    add_column :accions, :project_risk_id, :integer
    remove_column :accions, :problem_id
    remove_column :accions, :risk_id
  end
end
