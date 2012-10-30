class Accion < ActiveRecord::Base
  default_scope order("title")

  belongs_to :user
  belongs_to :responsible_user, :class_name => "User", :foreign_key => "responsible_user_id"
  belongs_to :action_priority
  belongs_to :action_source_type
  belongs_to :action_state
  belongs_to :project
  belongs_to :problem
  belongs_to :risk

  has_many :action_trackings, :order => 'tracking_date', :dependent => :destroy

  accepts_nested_attributes_for :action_trackings, :reject_if => lambda { |a| a[:user_id].blank? && a[:description].blank? && a[:tracking_date].blank?}, :allow_destroy => true

  #:reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? }}   #(para reject de todos los campos)
  # o probar con este: proc { |attributes| attributes.all? { |_, value| value.blank? } }

  attr_accessible :title, :description, :commitment_date, :user_id, :responsible_user_id, :problem_id, :action_source_type_id, :action_state_id, :action_priority_id, :project_id, :risk_id
  attr_accessible :action_trackings_attributes

  validates_presence_of :title, :responsible_user, :action_state_id, :action_priority, :action_source_type
  validates_presence_of :problem_id, :if => :should_validate_problem?
  validates_presence_of :risk_id, :if => :should_validate_risk?
  attr_accessor :creating_from_risk #desde risk_controller o problem_controller seteo esto a true, para que no valide la precencia del risk_id ni problem_id
  attr_accessor :creating_from_problem #desde risk_controller o problem_controller seteo esto a true, para que no valide la precencia del risk_id ni problem_id

  scope :opens, where("action_state_id = ? ", ActionState.open)
  scope :closed, where("action_state_id = ? ", ActionState.closed)


  def should_validate_risk?
    action_source_type == ActionSourceType.find_by_i18n_name("risk") && !creating_from_risk
  end

  def should_validate_problem?
    action_source_type == ActionSourceType.find_by_i18n_name("problem") && !creating_from_problem
  end

end
