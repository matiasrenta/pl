class RemoveTreatmentDateFromRisks < ActiveRecord::Migration
  def self.up
    remove_column :risks, :treatment_date
  end

  def self.down
    add_column :risks, :treatment_date, :date
  end
end
