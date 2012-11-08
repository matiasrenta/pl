class AddRemoveFieldsToCoatingsProductsFinishes < ActiveRecord::Migration
  def self.up
    remove_column :products, :description
    remove_column :coatings, :description
    remove_column :finishes, :description

    add_column :products, :code, :string
    add_column :coatings, :code, :string
    add_column :finishes, :code, :string
  end

  def self.down
    add_column :products, :description, :text
    add_column :coatings, :description, :text
    add_column :finishes, :description, :text

    remove_column :products, :code
    remove_column :coatings, :code
    remove_column :finishes, :code

  end
end
