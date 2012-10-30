class DropExpenseTypeUserJoins < ActiveRecord::Migration
  def self.up
    drop_table :expense_type_user_joins
  end

  def self.down
  end
end
