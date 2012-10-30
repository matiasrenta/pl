class Problem < ActiveRecord::Base
  default_scope order("name")

  belongs_to :problem_state
  belongs_to :problem_severity
  belongs_to :problem_priority
  belongs_to :project
  belongs_to :user
  belongs_to :responsible_user, :class_name => "User", :foreign_key => "responsible_user_id"
  #belongs_to :treatment_user, :class_name => "User", :foreign_key => "treatment_user_id"
  #belongs_to :monitor_user, :class_name => "User", :foreign_key => "monitor_user_id"

  has_many :accions

  accepts_nested_attributes_for :accions, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  attr_accessible :name, :description, :project_id, :user_id, :responsible_user_id, :problem_severity_id, :problem_priority_id, :problem_state_id
  attr_accessible :accions_attributes


  validates_presence_of :name, :responsible_user_id, :user_id, :problem_state_id

  scope :opens, where("problem_state_id = ?", ProblemState.open.id)
  scope :to_project, lambda { |project_id| where("project_id = ?", project_id) }


  def closed?
    problem_state == ProblemState.find_by_i18n_name("closed")
  end
end
