class AddRemoveSomeFieldsFromExpenses < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :real_currency
    remove_column :expenses, :base_currency
    remove_column :expenses, :planed_amount
    remove_column :expenses, :expense_amount
    remove_column :expenses, :real_amount
    remove_column :expenses, :comprobante
    remove_column :expenses, :no_comprobante

    add_column :expenses, :currency, :string
    add_column :expenses, :amount_cents, :integer
    add_column :expenses, :receipt, :boolean
    add_column :expenses, :receipt_code, :string
  end

  def self.down
  end
end
