class CreateQuotations < ActiveRecord::Migration
  def self.up
    create_table :quotations do |t|
      t.string :name
      t.text :observations

      t.timestamps
    end
  end

  def self.down
    drop_table :quotations
  end
end
