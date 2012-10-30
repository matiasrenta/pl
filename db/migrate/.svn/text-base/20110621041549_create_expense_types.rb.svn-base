class CreateExpenseTypes < ActiveRecord::Migration
  def self.up
    create_table :expense_types do |t|
      t.string :title
      t.text :description
      t.boolean :reported
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :expense_types
  end
end
