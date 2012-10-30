class ProblemState < ActiveRecord::Base
  has_many :problems

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.ProblemState.' + self.i18n_name
  end

  def self.open
    ProblemState.find_by_i18n_name("open")
  end

  def self.closed
    ProblemState.find_by_i18n_name("closed")
  end
end
