class RiskImpact < ActiveRecord::Base
  has_many :risk_exposition_strategies
  has_many :risks

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.RiskImpact.' + self.i18n_name
  end

end
