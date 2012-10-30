class RevoveTreatmentIdFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :treatment_id
  end

  def self.down
    add_column :users, :treatment_id, :integer
  end
end
