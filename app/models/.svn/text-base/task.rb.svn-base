class Task < ActiveRecord::Base
  default_scope order("planned_start_date ASC")

  #has_paper_trail

  belongs_to :task_state
  belongs_to :task_type
  belongs_to :life_cycle
  belongs_to :life_cycle_phase
  belongs_to :project
  belongs_to :user

  belongs_to :parent, :class_name => "Task", :foreign_key => :parent_id
  has_many :children, :class_name => "Task", :foreign_key => :parent_id, :dependent => :nullify #esto pone a NULL la foreign key (porque no quiero borrar las tareas, sino solo el link de predesesora)

  has_many :task_progresses #, :dependent => :destroy

  composed_of :planned_cost,
              :class_name => "Money",
              :mapping => [%w(planned_cost_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :real_cost,
              :class_name => "Money",
              :mapping => [%w(real_cost_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }


  before_validation :set_planned_values #, :on => :create

  validates_presence_of [:name, :user_id, :planned_start_date, :planned_end_date, :planned_duration, :planned_hours, :planned_cost, :life_cycle_id, :life_cycle_phase, :task_state]
  validates_uniqueness_of :name
  validates_numericality_of :planned_duration, :greater_than_or_equal_to => 1
  validates_numericality_of :planned_hours, :greater_than_or_equal_to => 1
  #validates_numericality_of :parent_id, :if => "!parent_id.blank?"
  validate :check_parent_id, :if => "!parent_id.blank?"
  validate :check_phase_estimation, :if => "planned_hours"

  #ejemplo Agus: Task.in_progress.of_user(current_user).from_date(Time.now).of_project(project_id)
  scope :of_project, lambda {|project| where("tasks.project_id = ?", project)}
  scope :of_user, lambda {|user| where("tasks.user_id = ?", user)}

  scope :assigned,    where("tasks.task_state_id = ?", TaskState.assigned)
  scope :in_progress, where("tasks.task_state_id = ?", TaskState.in_progress)
  scope :delayed,     where("tasks.task_state_id = ?", TaskState.delayed)
  scope :closed,      where("tasks.task_state_id = ?", TaskState.closed)
  scope :canceled,    where("tasks.task_state_id = ?", TaskState.canceled)

  #scope :assigned_OR_in_progress_OR_delayed, where("tasks.task_state_id IN (?)", [TaskState.assigned, TaskState.in_progress, TaskState.delayed]).order("planned_start_date DESC")

  #before_save :do_it
  #before_update :set_calculated_values_at_update

  def assigned?
    self.task_state == TaskState.assigned
  end
  def in_progress?
    self.task_state == TaskState.in_progress
  end
  def delayed?
    self.task_state == TaskState.delayed
  end
  def closed?
    self.task_state == TaskState.closed
  end
  def canceled?
    self.task_state == TaskState.canceled
  end

  #la suma de las tareas no puede superar los valores de estimacion de la fase. todo: validamos tambien que no se pase de la fecha fin de la fase o no?
  def check_phase_estimation
    return false if !life_cycle_phase
    planned_hours_phase = self.project.projects_phases_joins.where("life_cycle_phase_id = ?", self.life_cycle_phase.id).first.planned_hours_phase
    if self.new_record?
      sum_hours_tasks = self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase.id).sum("planned_hours")
    else
      sum_hours_tasks = self.project.tasks.where("life_cycle_phase_id = ? AND id <> ?", self.life_cycle_phase.id, self.id).sum("planned_hours")
    end
    sum_hours_tasks = sum_hours_tasks + self.planned_hours
    if (sum_hours_tasks) > planned_hours_phase
      errors.add(:planned_hours, I18n.t("screens.alerts.tasks_exceeded_in_hours"))
      return false
    end
    return true
  end

  def check_parent_id
    if Task.where("id = ? AND project_id = ?", self.parent_id, self.project_id).count <= 0
      errors.add(:parent_id, I18n.t("screens.alerts.wrong_task_id"))
      return false
    end
    return true
  end

  def on_time
    coefficient = 0.00
    if closed? || canceled?
      if planned_end_date < real_end_date
        coefficient = Holiday.how_many_working_days(planned_end_date, real_end_date, project_id) / planned_duration
      end
    elsif in_progress?
      if planned_end_date < Date.today
        coefficient = Holiday.how_many_working_days(planned_start_date, Date.today, project_id) / planned_duration
      elsif planned_start_date < real_start_date
        coefficient = Holiday.how_many_working_days(planned_start_date, real_start_date, project_id) / planned_duration
      end
    else #assigned
      if planned_start_date < Date.today
        coefficient = Holiday.how_many_working_days(planned_start_date, Date.today, project_id) / planned_duration
      end
    end
    coefficient
  end

  def in_time
    coefficient = 0.00
    if !canceled?
      if closed?
        if real_hours > planned_hours
          coefficient = Float(real_hours - planned_hours) / Float(planned_hours)
        end
      elsif assigned? || in_progress?
        rh = real_hours ? real_hours : 0
        pen = planned_effort_now
        if pen > 0 && rh > pen
          coefficient = Float(rh - pen) / Float(pen)
        end
      end
    end
    return 100 * coefficient
  end

  def progress_deviation
    coefficient = 0
    rp = real_progress ? real_progress : 0
    if planned_progress_now_percent > rp
      coefficient = planned_progress_now_percent - rp
    end
    coefficient
  end


#  def on_time
#    coefficient = 0.00
#    if closed? || canceled?
#      if planned_end_date < real_end_date
#        coefficient = (real_end_date - planned_end_date) / planned_duration #Holiday.how_many_working_days(planned_end_date, real_end_date, project_id) / planned_duration
#      end
#    elsif in_progress?
#      if planned_end_date < Date.today
#        coefficient = (Date.today - planned_start_date) / planned_duration #Holiday.how_many_working_days(planned_start_date, Date.today, project_id) / planned_duration
#      elsif planned_start_date < real_start_date
#        coefficient = (real_start_date - planned_start_date) / planned_duration #Holiday.how_many_working_days(planned_start_date, real_start_date, project_id) / planned_duration
#      end
#    else #assiged
#      if planned_start_date < Date.today
#        coefficient = (Date.today - planned_start_date) / planned_duration #Holiday.how_many_working_days(planned_start_date, Date.today, project_id) / planned_duration
#      end
#    end
#    coefficient
#  end


  def deviation_start_in_days
    (real_start_date - planned_start_date).to_i.abs if real_start_date
  end

  def deviation_end_in_days
    (real_end_date - planned_end_date).to_i.abs if real_end_date
  end

  def deviation_duration_in_days
    (real_duration - planned_duration).abs if real_duration
  end

  def self.build_task_from_phase(phase, project)
    task = Task.new
    task.project = project
    task.life_cycle = project.life_cycle
    task.currency = project.currency
    task.task_state = TaskState.find_by_i18n_name("assigned")
    task.life_cycle_phase = phase
    return task
  end

  def self.build_task_no_phase(project)
    task = Task.new
    task.project = project
    task.life_cycle = project.life_cycle
    task.currency = project.currency
    task.task_state = TaskState.find_by_i18n_name("assigned")
    return task
  end

  def task_closed?
    self.task_state == TaskState.find_by_i18n_name("closed")
  end

  def get_last_progress(date = Date.today)
    #TaskProgress.where(:task_id => self.id).order("working_day DESC").limit(1).first
    self.task_progresses.where("working_day <= ?", date).order("working_day DESC").first
  end


  def real_progress_decimal(date = Date.today)
    return 0.00 unless !real_progress.blank? && real_progress > 0
    Float(self.real_progress_now(date)) / 100
  end

  def real_progress_percent(date = Date.today)
    return 0 unless !real_progress.blank? && real_progress > 0
    self.real_progress_now(date)
  end

  def planned_progress_now(date = Date.today)
    return 0 if self.canceled?
    return 0 if date < self.planned_start_date
    return 1.00 if date > self.planned_end_date
    pass_days = Holiday.how_many_working_days(self.planned_start_date, date - 1.day, self.project_id)
    return Float(pass_days) / Float(self.planned_duration) #por ejemplo puede dar 80%
  end

  def planned_progress_now_percent(date = Date.today)
    (planned_progress_now(date) * 100).round
  end


  def planned_effort_now(date = Date.today)
    return 0 if self.canceled?
    return 0 if date < self.planned_start_date
    return self.planned_hours if date > self.planned_end_date
    pass_days = Holiday.how_many_working_days(self.planned_start_date, date - 1.day, self.project_id)
    return (Float(self.planned_hours) / Float(self.planned_duration) * pass_days).round
  end

  def planned_cost_now(date = Date.today)
    return 0.00 if self.canceled?
    return 0.00 if date < self.planned_start_date
    return Float(self.planned_cost) if date > self.planned_end_date
    Float(self.user.cost_hour_in_project(self.project)) * planned_effort_now(date)
  end

  #real progress es la ultima carga de progreso hecha hasta la fecha especificada
  def real_progress_now(date = Date.today)
    get_last_progress(date) ? get_last_progress(date).progress : 0
  end

  #real effort es la suma de las cargas de progreso hasta la fecha especificada
  def real_effort_now(date = Date.today)
    return 0 unless !real_hours.blank? && real_hours > 0
    self.task_progresses.where("working_day <= ?", date).sum(:effort)
  end

  def real_cost_now(date = Date.today)
    return 0 unless !real_hours.blank? && real_hours > 0
    Float(self.user.cost_hour_in_project(self.project)) * self.real_effort_now(date)
  end


  def cost_ev(date = Date.today)
    #puts self.name + " - real_progress_decimal(date) * planned_cost_now(date) = " + real_progress_decimal(date).to_s + " * " + planned_cost_now(date).to_s + " = " + (real_progress_decimal(date) * planned_cost_now(date)).to_s

    real_progress_decimal(date) * planned_cost_now(date)
  end

  def cost_pv(date = Date.today)
    #puts self.name + " - planned_progress_now(date) * planned_cost_now(date) = " + planned_progress_now(date).to_s + " * " + planned_cost_now(date).to_s + " = " + (planned_progress_now(date) * planned_cost_now(date)).to_s

    planned_progress_now(date) * planned_cost_now(date)
  end

  def hour_ev(date = Date.today)
    #puts "real_progress_decimal(date) * planned_effort_now(date) = " + real_progress_decimal(date).to_s + " * " + planned_effort_now(date) + " = " + (real_progress_decimal(date) * planned_effort_now(date)).to_s

    real_progress_decimal(date) * planned_effort_now(date)
  end

  def hour_pv(date = Date.today)
    planned_progress_now(date) * planned_effort_now(date)
  end

  def calculate_planned_end_date
    self.planned_start_date += 1.day while !Holiday.working_day?(self.project_id, self.planned_start_date)
    self.planned_end_date = self.planned_start_date
    (self.planned_duration - 1).times do
      self.planned_end_date += 1.day
      self.planned_end_date += 1.day while !Holiday.working_day?(self.project_id, self.planned_end_date)
    end
    return self.planned_end_date
  end

  def calculate_planned_hours
    self.planned_hours = planned_duration * self.project.hours_day
  end

  private ############################ PRIVATE ####################################

  def set_planned_values
    if self.user && self.planned_start_date && self.planned_duration && self.planned_hours
      self.planned_cost = self.user.cost_hour_in_project(self.project) * self.planned_hours
      calculate_planned_end_date
    end
  end

end
