class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holidays do |t|
      t.date :day
      t.text :description
      t.boolean :company
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :holidays
  end
end
