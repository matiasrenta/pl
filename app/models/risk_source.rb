class RiskSource < ActiveRecord::Base
  default_scope order("name")

  belongs_to :state

  has_many :risks

  has_and_belongs_to_many :risk_strategies, :join_table => "risk_strategy_risk_source_joins"

  validates_presence_of :name
end
