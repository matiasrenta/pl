class AddUserIdToRisks < ActiveRecord::Migration
  def self.up
    add_column :risks, :user_id, :integer
  end

  def self.down
    remove_column :risks, :user_id
  end
end
