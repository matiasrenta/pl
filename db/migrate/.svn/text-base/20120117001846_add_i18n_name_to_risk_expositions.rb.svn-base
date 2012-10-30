class AddI18nNameToRiskExpositions < ActiveRecord::Migration
  def self.up
    add_column :risk_expositions, :i18n_name, :string
    remove_column :risk_expositions, :name
  end

  def self.down
    remove_column :risk_expositions, :i18n_name
    add_column :risk_expositions, :name, :string
  end
end
