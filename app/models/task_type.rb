class TaskType < ActiveRecord::Base
  has_many :tasks

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.TaskType.' + self.i18n_name
  end

end
