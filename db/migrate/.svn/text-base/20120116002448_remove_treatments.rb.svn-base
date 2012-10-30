class RemoveTreatments < ActiveRecord::Migration
  def self.up
    drop_table :treatments
  end

  def self.down
    create_table :treatments do |t|
      t.string :name
      t.text :description
      t.integer :state_id

      t.timestamps
    end

  end
end
