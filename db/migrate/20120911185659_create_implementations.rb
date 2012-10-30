class CreateImplementations < ActiveRecord::Migration
  def self.up
    create_table :implementations do |t|
      t.integer :planned_progress
      t.integer :real_progress

      t.timestamps
    end
  end

  def self.down
    drop_table :implementations
  end
end
