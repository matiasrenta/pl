class CreateMachines < ActiveRecord::Migration
  def self.up
    create_table :machines do |t|
      t.string :name
      t.date :fecha

      t.timestamps
    end
  end

  def self.down
    drop_table :machines
  end
end
