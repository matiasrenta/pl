class ActionSourceType < ActiveRecord::Base
  has_many :accions

  validates_presence_of :i18n_name

  scope :risk_scope, where("i18n_name = ?", "risk")
  scope :problem_scope, where("i18n_name = ?", "problem")

  def name
    I18n.t 'activerecord.i18n_name.ActionSourceType.' + self.i18n_name
  end

  def self.problem
    find_by_i18n_name("problem")
  end

  def self.risk
    find_by_i18n_name("risk")
  end

  def self.decision
    find_by_i18n_name("decision")
  end

  def self.report
    find_by_i18n_name("report")
  end

end
