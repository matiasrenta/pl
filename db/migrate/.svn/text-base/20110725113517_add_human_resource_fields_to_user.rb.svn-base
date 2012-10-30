class AddHumanResourceFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name,             :string
    add_column :users, :last_name,        :string
    add_column :users, :mother_last_name, :string
    add_column :users, :work_phone,       :string
    add_column :users, :home_phone,       :string
    add_column :users, :cell_phone,       :string
    add_column :users, :cost_hour_cents,  :integer
    add_column :users, :currency,         :string
    add_column :users, :postal_code,      :string
    add_column :users, :is_external,      :boolean
    add_column :users, :company_id,       :integer
    add_column :users, :city_id,          :integer
    add_column :users, :treatment_id,     :integer
  end

  def self.down
    remove_column :users, :treatment_id
    remove_column :users, :city_id
    remove_column :users, :company_id
    remove_column :users, :is_external
    remove_column :users, :postal_code
    remove_column :users, :currency
    remove_column :users, :cost_hour_cents
    remove_column :users, :cell_phone
    remove_column :users, :home_phone
    remove_column :users, :work_phone
    remove_column :users, :mother_last_name
    remove_column :users, :last_name
    remove_column :users, :name
  end
end
