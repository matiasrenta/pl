class AddOffToDaysOff < ActiveRecord::Migration
  def self.up
    add_column :days_off, :off, :boolean
  end

  def self.down
    remove_column :days_off, :off
  end
end

