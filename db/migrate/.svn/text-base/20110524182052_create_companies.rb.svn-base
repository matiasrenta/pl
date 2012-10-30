class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :phone_1
      t.string :phone_2
      t.string :postal_code
      t.integer :company_type_id
      t.integer :city_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
