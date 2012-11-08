class RemoveSomeFieldsFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :resource
    remove_column :users, :cost_hour_cents
    remove_column :users, :currency
    remove_column :users, :home_phone
    remove_column :users, :postal_code
  end

  def self.down
    add_column :users, :resource, :boolean
    add_column :users, :cost_hour_cents, :integer
    add_column :users, :currency, :string
    add_column :users, :home_phone, :string
    add_column :users, :postal_code, :string
  end
end
