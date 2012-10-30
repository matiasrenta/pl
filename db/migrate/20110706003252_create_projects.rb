class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :code
      t.date :planned_start_date
      t.date :real_start_date
      t.integer :budget_cents, :default => 0, :null => false
      t.integer :risk_fund_cents, :default => 0, :null => false
      t.integer :expense_fund_cents, :default => 0, :null => false
      t.string  :currency
      t.integer :state_id
      t.integer :risk_strategy_id
      t.integer :life_cycle_id
      t.integer :project_state_id
      t.integer :area_id
      t.integer :city_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
