class CreateAjaxtests < ActiveRecord::Migration
  def self.up
    create_table :ajaxtests do |t|
      t.string :name
      t.text :description
      t.date :fecha
      t.integer :precio_cents
      t.integer :life_cycle_id
      t.integer :life_cycle_phase_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ajaxtests
  end
end
