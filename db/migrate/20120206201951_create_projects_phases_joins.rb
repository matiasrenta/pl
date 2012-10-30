class CreateProjectsPhasesJoins < ActiveRecord::Migration
  def self.up
    create_table :projects_phases_joins do |t|
      t.integer :planned_hours_phase
      t.integer :planned_cost_phase_cents
      t.integer :project_id
      t.integer :life_cycle_phase_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects_phases_joins
  end
end
