class RemoveCodeFromCountries < ActiveRecord::Migration
  def self.up
    remove_column :countries, :code
  end

  def self.down
    add_column :countries, :code, :string
  end
end
