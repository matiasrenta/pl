class ProjectState < ActiveRecord::Base
  has_many :projects

  validates_presence_of :i18n_name

  scope :created_in_progress_and_suspended, find_all_by_i18n_name(["created", "in_progress", "suspended"])
  scope :in_progress_and_suspended, find_all_by_i18n_name(["in_progress", "suspended"])
  scope :closed_and_canceled, find_all_by_i18n_name(["closed", "canceled"])

  def self.created
    find_by_i18n_name("created")
  end

  def self.in_progress
    find_by_i18n_name("in_progress")
  end

  def self.suspended
    find_by_i18n_name("suspended")
  end

  def self.canceled
    find_by_i18n_name("canceled")
  end

  def self.closed
    find_by_i18n_name("closed")
  end


  def name
    I18n.t 'activerecord.i18n_name.ProjectState.' + self.i18n_name
  end

end
