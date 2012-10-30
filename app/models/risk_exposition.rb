class RiskExposition < ActiveRecord::Base
  belongs_to :state
  has_many :risk_exposition_strategies

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.RiskExposition.' + self.i18n_name
  end

end
