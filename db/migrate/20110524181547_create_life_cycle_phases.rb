class CreateLifeCyclePhases < ActiveRecord::Migration
  def self.up
    create_table :life_cycle_phases do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.integer :life_cycle_id
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :life_cycle_phases
  end
end
