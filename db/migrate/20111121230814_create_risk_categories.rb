class CreateRiskCategories < ActiveRecord::Migration
  def self.up
    create_table :risk_categories do |t|
      t.string :name
      t.text :description
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_categories
  end
end
