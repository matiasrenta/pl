class RemoveBudgetCentsAddSalePriceToProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :budget_cents
    add_column :projects, :sale_price_cents, :integer
  end

  def self.down
    add_column :projects, :budget_cents, :integer
    remove_column :projects, :sale_price_cents
  end
end
