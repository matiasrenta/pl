class CompanyType < ActiveRecord::Base
  has_many :companies

  validates_presence_of :i18n_name

  def self.customer
    find_by_i18n_name("customer")
  end

  def name
    I18n.t 'activerecord.i18n_name.CompanyType.' + self.i18n_name
  end

end
