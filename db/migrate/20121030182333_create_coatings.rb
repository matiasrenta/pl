class CreateCoatings < ActiveRecord::Migration
  def self.up
    create_table :coatings do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :coatings
  end
end
