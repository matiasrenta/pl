class RiskStrategy < ActiveRecord::Base
  default_scope order("name")

  has_many :projects

  belongs_to :user
  belongs_to :state

  has_and_belongs_to_many :risk_sources, :join_table => "risk_strategy_risk_source_joins"

  validates_presence_of :name

end
