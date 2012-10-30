class TaskState < ActiveRecord::Base
  has_paper_trail
  has_many :tasks

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.TaskState.' + self.i18n_name
  end

  def self.get_proper_states_for_combobox(task)
    if task.assigned?
      find_all_by_i18n_name(["assigned", "canceled"])
    elsif task.in_progress?
      find_all_by_i18n_name(["in_progress", "canceled"])
    elsif task.delayed?
      find_all_by_i18n_name(["delayed", "canceled"])
    elsif task.closed?
      find_by_i18n_name("closed")
    elsif task.canceled?
      find_by_i18n_name("canceled")
    end
  end

  def self.assigned
    TaskState.find_by_i18n_name("assigned")
  end

  def self.in_progress
    TaskState.find_by_i18n_name("in_progress")
  end

  def self.delayed
    TaskState.find_by_i18n_name("delayed")
  end

  def self.canceled
    TaskState.find_by_i18n_name("canceled")
  end

  def self.closed
    TaskState.find_by_i18n_name("closed")
  end

  def self.assigned_in_progress_delayed
    find_all_by_i18n_name("assigned", "in_progress", "delayed")
  end

end
