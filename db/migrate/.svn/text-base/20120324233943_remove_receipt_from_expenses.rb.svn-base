class RemoveReceiptFromExpenses < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :receipt
  end

  def self.down
    add_column :expenses, :receipt, :boolean
  end
end
