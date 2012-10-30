class RegionState < ActiveRecord::Base
  default_scope order("name")

  belongs_to :state
  belongs_to :country
  has_many :cities

  validates_presence_of :name, :country, :state

  def open
    RiskState.find_by_i18n_name("open")
  end
end
