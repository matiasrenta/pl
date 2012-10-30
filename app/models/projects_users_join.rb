class ProjectsUsersJoin < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :state

  validates_presence_of :project_id, :user_id, :hour_cost_in_project, :currency, :state
  validates_numericality_of :hour_cost_in_project, :greater_than => 0
  validates_uniqueness_of :project_id, :scope => :user_id, :message => I18n.t("screens.errors.user_already_assigned")

  composed_of :hour_cost_in_project,
              :class_name => "Money",
              :mapping => [%w(hour_cost_in_project_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }


  before_update :activated_inactivate_logic
  before_destroy :check_if_leader, :check_tasks

  def inactive?
    state == State.inactive
  end

  def active?
    state == State.active
  end

  def self.not_assigned_to_project (p_id = 0, u_id = 0)
    return find_by_sql ["SELECT * FROM users WHERE not exists
                          (select * from projects_users_joins where user_id = users.id AND project_id = ?)
                         UNION
                         SELECT * FROM users WHERE id = ?
                         ORDER BY name, last_name", p_id, u_id]
  end

  def self.resource_cost_hour(user_id, project_id)
    User.find(user_id).cost_hour.exchange_to( Project.find(project_id).currency )
  end

  def has_tasks?
    ProjectsUsersJoin.joins(:project => :tasks).where("tasks.user_id = ?", user_id).count > 0
  end

  def has_assigned_in_progress_delayed_tasks?
    ProjectsUsersJoin.joins(:project => :tasks).where("tasks.user_id = ? AND tasks.task_state_id IN (?)", user_id, TaskState.assigned_in_progress_delayed).count > 0
  end

  private

  def validate
    errors.add(:state_id, I18n.t("screens.alerts.cant_destroy_leader")) if leader && state == State.inactive
    errors.add(:state_id, I18n.t("screens.errors.user_is_inactive")) if user.inactive? && state == State.active
  end

  def check_if_leader
    if self.leader
      errors.add(:base, I18n.t("screens.alerts.cant_destroy_leader"))
      return false
    end
  end

  def check_tasks
    if has_tasks?
      self.state = State.inactive
      save
      errors.add(:tasks_present, I18n.t("screens.errors.puj_has_being_inactivated"))
      return false
    end
    return true
  end

  def activated_inactivate_logic
    ddbb_puj = ProjectsUsersJoin.find(id)
    if state == State.inactive && state != ddbb_puj.state #es decir, si se esta inactivando esta asignacion, entonces...
      if has_assigned_in_progress_delayed_tasks?
        errors.add(:info_reassign_tasks, I18n.t("screens.info.when_inactivate_resource_with_task"))
        #todo: logica para enviar mail (deberia hacerlo en el controller, pero no puedo porque sino cuando el Admin inactive el usuario, no se enviara mail)
      end
    end
  end

  def can_be_activated?
    user.active?
  end

end
