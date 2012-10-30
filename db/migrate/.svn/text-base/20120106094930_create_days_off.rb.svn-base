class CreateDaysOff < ActiveRecord::Migration
  def self.up
    create_table :days_off do |t|
      t.integer :wday
      t.boolean :company
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :days_off
  end
end
