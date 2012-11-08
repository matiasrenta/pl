class User < ActiveRecord::Base
  default_scope order("users.name, last_name, mother_last_name")

  belongs_to :company
  belongs_to :city
  belongs_to :last_project_viewed, :class_name => "Project", :foreign_key => "last_project_viewed_id"
  belongs_to :state
  belongs_to :role

  has_many :tasks
  has_many :news_items
  has_many :lessons
  has_many :risk_strategies
  has_many :expenses
  has_many :user_recorder, :class_name => 'Expense', :foreign_key => 'user_recorder_id'
  has_many :action_trackings

  has_many :accions
  has_many :responsible_user, :class_name => 'Accion', :foreign_key => 'responsible_user_id'
  has_many :risks
  has_many :risk_responsible_users, :class_name => "Risk", :foreign_key => "responsible_user_id"
  has_many :problems
  has_many :problem_responsible_users, :class_name => 'Problem', :foreign_key => 'responsible_user_id'

  has_many :leaders, :class_name => "Project", :foreign_key => :leader_id
  has_many :projects_users_joins
  has_many :projects, :through => :projects_users_joins
  has_and_belongs_to_many :project_dashboards, :join_table => "project_dashboard_present_user_joins"

  has_and_belongs_to_many :view_projects, :join_table => "customers_projects_joins", :class_name => "Project", :association_foreign_key => "project_id"


  validates_presence_of :name, :last_name, :email, :role_id, :state_id
  validates_presence_of :company , :message => I18n.t("screens.alerts.if_customer_company_required"), :unless => "!role.customer?"
  validate :email,  :length => {:minimum => 3, :maximum => 100},
                    :uniqueness => true,
                    :email => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable#, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :reset_password_token, :role_id, :name, :last_name, :mother_last_name,
                  :work_phone, :home_phone, :cell_phone, :cost_hour, :cost_hour_cents, :currency, :postal_code,
                  :company_id, :city_id, :treatment_id, :last_project_viewed_id, :state_id, :resource
  #attr_accessible :customer_projects_attributes

  ROLES = %w[admin ceo lider developer customer]

  default_scope order(:name, :last_name)

  before_update :inactivate_logic


  def full_name
    "#{name} #{last_name}"
  end

  def active?
    state == State.active
  end

  def inactive?
    state == State.inactive
  end


  private

  def inactivate_logic
    if inactivating_or_no_more_resource? #es decir, si lo esta inactivando o ya no es mas resource, entonces...
      if projects_created_in_progress_suspended.count > 0
        #destroy (lo inabilita si no puede) todas las asignaciones de este recurso en los projectos "projects_created_in_progress_suspended"
        projects_created_in_progress_suspended.each do |project|
          puj = project.projects_users_joins.where("projects_users_joins.user_id = ? AND projects_users_joins.leader <> ?", id, true).first
          if puj #puede que sea el lider, en ese caso no hago nada con el puj
            puj.destroy
            if puj.errors.has_key?(:info_reassign_tasks)
              errors.add(:info_reassign_tasks, puj.errors[:info_reassign_tasks])
            end

          end
        end
      end
    end
  end

  def inactivating_or_no_more_resource?
    ddbb_user = User.find(id)
    return (state == State.inactive && state != ddbb_user.state)
  end


end


