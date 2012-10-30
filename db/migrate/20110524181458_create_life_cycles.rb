class CreateLifeCycles < ActiveRecord::Migration
  def self.up
    create_table :life_cycles do |t|
      t.string :name
      t.text :description
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :life_cycles
  end
end
