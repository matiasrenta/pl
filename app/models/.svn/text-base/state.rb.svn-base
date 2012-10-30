class State < ActiveRecord::Base
  has_many :life_cycles
  has_many :areas
  has_many :risk_strategies
  has_many :expense_types
  has_many :risk_sources
  has_many :companies
  has_many :countries
  has_many :region_states
  has_many :cities
  has_many :users
  has_many :projects_users_joins

  validates_presence_of :name

  def self.active
    find_by_i18n_name("active")
  end

  def self.inactive
    find_by_i18n_name("inactive")
  end


  def name
    I18n.t 'activerecord.i18n_name.state.' + self.i18n_name
  end

end
