class ProblemSeverity < ActiveRecord::Base
  has_many :problems

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.ProblemSeverity.' + self.i18n_name
  end

end
