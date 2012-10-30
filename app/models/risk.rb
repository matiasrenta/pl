class Risk < ActiveRecord::Base
  default_scope order("name")

  belongs_to :project
  belongs_to :risk_source
  belongs_to :risk_probability
  belongs_to :risk_impact
  belongs_to :risk_exposition
  belongs_to :user
  belongs_to :responsible_user, :class_name => "User", :foreign_key => "responsible_user_id"
  #belongs_to :monitor_responsible_user, :class_name => "User", :foreign_key => "monitor_responsible_user_id"
  #belongs_to :treatment_responsible_user, :class_name => "User", :foreign_key => "treatment_responsible_user_id"
  belongs_to :risk_state
  belongs_to :life_cycle_phase

  has_many :accions, :dependent => :destroy

  composed_of :real_cost,
              :class_name => "Money",
              :mapping => [%w(real_cost_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  accepts_nested_attributes_for :accions, :reject_if => lambda { |a| a[:title].blank? && a[:description].blank? && a[:responsible_user_id].blank? && a[:commitment_date].blank? }, :allow_destroy => true
  attr_accessible :name, :description, :detection_date, :umbral, :mitigation, :contingency, :real_cost, :real_cost_cents, :currency,
                  :project_id, :risk_source_id, :life_cycle_phase_id, :risk_probability_id, :risk_impact_id, :risk_exposition_strategy_id, :responsible_user_id, :risk_state_id, :user_id
  attr_accessible :accions_attributes


  validates_presence_of :name, :description, :detection_date, :risk_probability_id, :risk_impact_id, :risk_exposition_id, :risk_state_id

  before_validation :calculate_values

  scope :opens, where("risk_state_id = ?", RiskState.open.id)
  scope :to_project, lambda { |project_id| where("project_id = ?", project_id) }


  def calculate_values
    #self.risk_exposition_strategy = RiskExpositionStrategy.where("risk_probability_id = ? AND risk_impact_id = ?", self.risk_probability_id, self.risk_impact_id).first
    if self.risk_probability && self.risk_impact
      case self.risk_probability.i18n_name + " " + self.risk_impact.i18n_name
        when "low low":             self.risk_exposition = RiskExposition.find_by_i18n_name("low")
        when "low medium":          self.risk_exposition = RiskExposition.find_by_i18n_name("low")
        when "low high":            self.risk_exposition = RiskExposition.find_by_i18n_name("medium")
        when "low very_high":       self.risk_exposition = RiskExposition.find_by_i18n_name("medium")

        when "medium low":          self.risk_exposition = RiskExposition.find_by_i18n_name("low")
        when "medium medium":       self.risk_exposition = RiskExposition.find_by_i18n_name("medium")
        when "medium high":         self.risk_exposition = RiskExposition.find_by_i18n_name("high")
        when "medium very_high":    self.risk_exposition = RiskExposition.find_by_i18n_name("high")

        when "high low":            self.risk_exposition = RiskExposition.find_by_i18n_name("medium")
        when "high medium":         self.risk_exposition = RiskExposition.find_by_i18n_name("high")
        when "high high":           self.risk_exposition = RiskExposition.find_by_i18n_name("high")
        when "high very_high":      self.risk_exposition = RiskExposition.find_by_i18n_name("very_high")

        when "very_high low":       self.risk_exposition = RiskExposition.find_by_i18n_name("medium")
        when "very_high medium":    self.risk_exposition = RiskExposition.find_by_i18n_name("high")
        when "very_high high":      self.risk_exposition = RiskExposition.find_by_i18n_name("very_high")
        when "very_high very_high": self.risk_exposition = RiskExposition.find_by_i18n_name("very_high")
      end
    end
  end

  def closed?
    risk_state == RiskState.find_by_i18n_name("closed")
  end

end
