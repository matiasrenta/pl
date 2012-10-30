class RiskState < ActiveRecord::Base
  has_many :risks

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.RiskState.' + self.i18n_name
  end

  def self.open
    RiskState.find_by_i18n_name("open")
  end

  def self.closed
    RiskState.find_by_i18n_name("closed")
  end

end
