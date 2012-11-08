class CreateQuotationFeatures < ActiveRecord::Migration
  def self.up
    create_table :quotation_features do |t|
      t.integer :pages
      t.integer :inks
      t.integer :final_measure_width
      t.integer :final_measure_height
      t.boolean :front
      t.boolean :back
      t.integer :paper_id
      t.integer :coating_id
      t.integer :finish_id

      t.timestamps
    end
  end

  def self.down
    drop_table :quotation_features
  end
end
