class AddI18nNameToRiskImpacts < ActiveRecord::Migration
  def self.up
    add_column :risk_impacts, :i18n_name, :string
    remove_column :risk_impacts, :name
  end

  def self.down
    remove_column :risk_impacts, :i18n_name
    add_column :risk_impacts, :name, :string
  end
end
