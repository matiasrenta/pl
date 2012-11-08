class CreatePressTypes < ActiveRecord::Migration
  def self.up
    create_table :press_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :press_types
  end
end
