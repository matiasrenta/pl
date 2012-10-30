class CreateExpeseTypeUserJoin < ActiveRecord::Migration
  def self.up
    create_table :expense_type_user_joins, :id => false do |t|
      t.integer :expense_type_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :expense_type_user_joins
  end

end
