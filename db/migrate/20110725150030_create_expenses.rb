class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.integer :expense_type_id
      t.integer :user_id
      t.integer :user_recorder_id
      t.integer :project_id
      t.string :real_currency
      t.string :base_currency
      t.string :comprobante
      t.boolean :no_comprobante
      t.integer :expense_amount
      t.integer :planed_amount
      t.integer :real_amount
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
