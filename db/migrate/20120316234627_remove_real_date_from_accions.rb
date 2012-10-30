class RemoveRealDateFromAccions < ActiveRecord::Migration
  def self.up
    remove_column :accions, :real_date
  end

  def self.down
    add_column :accions, :real_date, :date
  end
end
