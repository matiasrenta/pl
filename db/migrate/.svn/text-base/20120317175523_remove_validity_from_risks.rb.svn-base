class RemoveValidityFromRisks < ActiveRecord::Migration
  def self.up
    remove_column :risks, :validity_from
    remove_column :risks, :validity_to
  end

  def self.down
    add_column :risks, :validity_from, :date
    add_column :risks, :validity_to, :date
  end
end
