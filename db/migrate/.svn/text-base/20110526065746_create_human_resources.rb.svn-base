class CreateHumanResources < ActiveRecord::Migration
  def self.up
    create_table :human_resources do |t|
      t.string :name
      t.string :last_name
      t.string :mother_last_name
      t.string :work_phone
      t.string :home_phone
      t.string :cell_phone
      t.integer :cost_hour_cents, :default => 0, :null => false
      t.string :currency
      t.boolean :is_external
      t.integer :company_id
      t.integer :city_id
      t.string :postal_code
      t.integer :treatment_id
      t.integer :user_id
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :human_resources
  end
end
