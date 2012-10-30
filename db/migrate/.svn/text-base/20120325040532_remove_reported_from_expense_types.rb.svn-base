class RemoveReportedFromExpenseTypes < ActiveRecord::Migration
  def self.up
    remove_column :expense_types, :reported
  end

  def self.down
    add_column :expense_types, :reported, :boolean
  end
end
