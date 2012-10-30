class CreateDayHours < ActiveRecord::Migration
  def self.up
    create_table :day_hours do |t|
      t.integer :hours
    end
  end

  def self.down
    drop_table :day_hours
  end
end
