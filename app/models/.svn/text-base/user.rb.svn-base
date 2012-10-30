class User < ActiveRecord::Base
  #default_scope order("name, last_name, mother_last_name")
  #default_scope where("role_id <> ?", Role.unscoped.superuser.id).order("users.name, last_name, mother_last_name")
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


  validates_presence_of :name, :last_name, :email, :role_id, :state_id, :currency
  validates_presence_of :company , :message => I18n.t("screens.alerts.if_customer_company_required"), :unless => "!role.customer?"
  validates_numericality_of :cost_hour, :greater_than => 0, :message => I18n.t("screens.alerts.if_resource_cost_required"), :if => "resource"
  validates_exclusion_of :role_id, :in => [Role.customer.id], :message => I18n.t("screens.alerts.if_resource_cant_be_customer"), :if => "resource"
  validate :email,  :length => {:minimum => 3, :maximum => 100},
                    :uniqueness => true,
                    :email => true


  composed_of :cost_hour,
              :class_name => "Money",
              :mapping => [%w(cost_hour_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }


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
  scope :resources, where("users.resource = ?", true)
  scope :leaders, where("role_id = ?", Role.leader.id)
  scope :can_be_leaders, where("role_id IN (?)", [Role.leader.id, Role.leader2.id, Role.ceo.id, Role.admin.id])
  scope :not_assigned_to, lambda { |project_id|
    find_by_sql ["SELECT * FROM users
                        WHERE not exists (select * from projects_users_joins puj where puj.user_id = users.id AND puj.project_id = ? AND puj.state_id = ?)", project_id, State.active.id]
  }
  scope :assigned_to, lambda { |project_id|
    find_by_sql ["SELECT * FROM users
                        WHERE exists (select * from projects_users_joins puj where puj.user_id = users.id AND puj.project_id = ? AND puj.state_id = ?)", project_id, State.active.id]
  }

  #scope :not_assigned_to_project, lambda { |p_id| find_by_sql ["SELECT * FROM users WHERE not exists (select * from projects_users_joins where user_id = users.id AND project_id = ?) ORDER BY users.name, users.last_name", p_id] }


  before_update :inactivate_logic



  def self.not_assigned_to_project_with_actual_user (p_id = 0, u_id = 0)
    return find_by_sql ["SELECT * FROM users WHERE not exists
                          (select * from projects_users_joins where user_id = users.id AND project_id = ?)
                         UNION
                         SELECT * FROM users WHERE id = ?
                         ORDER BY name, last_name", p_id, u_id]
  end

  def self.assigned_to_project(p_id = 0)
    project = Project.find(p_id)
    #project.users
    project.resources_assigned_and_actives
  end



  def full_name
    "#{name} #{last_name}"
  end

  def active?
    state == State.active
  end

  def inactive?
    state == State.inactive
  end

  def cost_hour_in_project(project)
    puj = self.projects_users_joins.where("project_id = ?", project.id).first
    puj.hour_cost_in_project.exchange_to(project.currency)
  end

  def cost_hour_in_currency(currency)
    cost_hour.exchange_to(currency)
  end

  def leader?(project)
    project.leader_id == self.id
  end

  def active_in_projects
    return Project.joins(:projects_users_joins => :user).where("users.id = ? AND projects_users_joins.state_id = ? AND projects.project_state_id NOT IN (?)", self.id, State.active.id, ProjectState.closed_and_canceled )
  end

  def projects_created_in_progress_suspended
    Project.created_in_progress_suspended.joins(:projects_users_joins => :user).where("users.id = ?", id)
  end

  def self.availability(date = Date.today, project = nil)
    start_date = date.beginning_of_month
    end_date   = start_date.end_of_month + 1.day
    days_count = (end_date - start_date).to_i #cantidad de dias del mes
    allowed_project_states = [ProjectState.created, ProjectState.in_progress].collect { |ps| ps.id }.join(", ")
    not_allowed_task_states = [TaskState.canceled, TaskState.closed].collect { |ts| ts.id }.join(", ")
    users = User.assigned_to(project.id).collect { |u| u.id }.join(",") if project
    users = User.resources.collect { |u| u.id }.join(",") if !project
    sub_sqls = Array.new
    day = start_date
    count = 1

    days_count.times do
      if Holiday.working_day?(project.id, day)
        sub_sqls << " (select ROUND(SUM(tasks.planned_hours / tasks.planned_duration))
                       from users u#{count} LEFT OUTER JOIN tasks ON tasks.user_id = u#{count}.id
                                       AND tasks.planned_start_date <= '#{day.strftime("%Y-%m-%d")}'
                                       AND tasks.planned_end_date >= '#{day.strftime("%Y-%m-%d")}'
                                       AND tasks.task_state_id NOT IN (#{not_allowed_task_states})
                                       LEFT JOIN projects ON tasks.project_id = projects.id
                                             AND project_state_id IN (#{allowed_project_states})
                       where u#{count}.id = users.id
                      ) as '#{count}'
                    "
      else
        sub_sqls << "NULL as '#{count}'" #si el dia es no labarable no sumo nada y lo dejo en NULL
      end
      day += 1.day
      count += 1
    end

    sql = "SELECT users.id, users.name, last_name, mother_last_name, #{sub_sqls.join(", ")}
            FROM users
            WHERE users.id IN (#{users})
            GROUP BY id, name, last_name, mother_last_name
            ORDER BY name, last_name, mother_last_name
          "

    return ActiveRecord::Base.connection.execute(sql)
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
    return (state == State.inactive && state != ddbb_user.state) || (!resource && ddbb_user.resource)
  end


end


