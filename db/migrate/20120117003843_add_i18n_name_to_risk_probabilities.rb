class AddI18nNameToRiskProbabilities < ActiveRecord::Migration
  def self.up
    add_column :risk_probabilities, :i18n_name, :string
    remove_column :risk_probabilities, :name
  end

  def self.down
    remove_column :risk_probabilities, :i18n_name
    add_column :risk_probabilities, :name, :string
  end
end
