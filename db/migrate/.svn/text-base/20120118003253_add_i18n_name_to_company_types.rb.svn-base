class AddI18nNameToCompanyTypes < ActiveRecord::Migration
  def self.up
    add_column :company_types, :i18n_name, :string
    remove_column :company_types, :name
  end

  def self.down
    remove_column :company_types, :i18n_name
    add_column :company_types, :name, :string
  end
end
