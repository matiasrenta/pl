class Project < ActiveRecord::Base
  default_scope order("projects.name")

  #has_paper_trail

  belongs_to :city
  belongs_to :risk_strategy
  belongs_to :life_cycle
  belongs_to :project_state
  belongs_to :area
  belongs_to :leader, :class_name => "User", :foreign_key => :leader_id
  belongs_to :company

  has_many :accions
  has_many :expenses
  has_many :projects_users_joins, :dependent => :destroy
  has_many :users, :through => :projects_users_joins
  has_many :last_project_vieweds, :class_name => "User", :foreign_key => "last_project_viewed_id", :dependent => :nullify
  has_many :tasks
  has_many :risks
  has_many :problems
  has_many :holidays, :dependent => :destroy
  has_many :days_off, :class_name => 'DayOff', :dependent => :destroy
  has_many :projects_phases_joins, :dependent => :destroy
  has_many :life_cycle_phases, :through => :projects_phases_joins
  has_many :project_dashboards
  has_many :lessons
  has_and_belongs_to_many :customers, :class_name => "User", :join_table => "customers_projects_joins", :association_foreign_key => "user_id"
  has_many :documents, :dependent => :delete_all
  has_many :news_items, :dependent => :delete_all
  has_many :implementations, :dependent => :delete_all

  validates_presence_of [:name, :currency, :risk_strategy_id, :project_state, :life_cycle_id, :leader, :company_id, :hours_day, :planned_resources_cost]
  validates_uniqueness_of :name
  validates_associated :projects_phases_joins

  #no lo uso ahora pero me sirve de ejemplo (devuelve todos los proyectos que un usuario tiene asignado)
  scope :assigned_projects, lambda {|user| joins(:projects_users_joins).where(:user_id => user.id)}


  composed_of :sale_price,
              :class_name => "Money",
              :mapping => [%w(sale_price_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :planned_resources_cost,
              :class_name => "Money",
              :mapping => [%w(planned_resources_cost_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }


  composed_of :risk_fund,
              :class_name => "Money",
              :mapping => [%w(risk_fund_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :expense_fund,
              :class_name => "Money",
              :mapping => [%w(expense_fund_cents cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }


  accepts_nested_attributes_for :projects_phases_joins#, :reject_if => lambda { |a| a[:planned_hours_phase].blank? || a[:planned_cost_phase].blank? }
  attr_accessible :id, :name, :description, :real_start_date, :real_end_date, :currency, :planned_resources_cost, :planned_resources_cost_cents, :sale_price, :sale_price_cents, :risk_fund, :risk_fund_cents, :expense_fund, :expense_fund_cents, :risk_strategy_id, :life_cycle_id, :project_state_id, :area_id, :city_id, :leader_id, :company_id, :hours_day
  attr_accessible :projects_phases_joins_attributes


  scope :in_progress, where("projects.project_state_id = ?", ProjectState.in_progress)
  scope :created_in_progress, where("projects.project_state_id IN (?)", [ProjectState.created, ProjectState.in_progress])
  scope :created_in_progress_suspended, where("projects.project_state_id IN (?)", ProjectState.created_in_progress_and_suspended)

  after_create :copy_company_calendar, :create_leader
  before_update :set_before_update
  after_update :update_leader


  def planned_start_date
    self.projects_phases_joins.minimum(:planned_start_date)
  end

  def planned_end_date
    self.projects_phases_joins.maximum(:planned_end_date)
  end



  def resources_assigned_and_actives
    #self.users.where("state_id = ?", State.find_by_i18n_name("active"))
    self.users.resources.actives
  end

  def resources_not_assigned_and_actives
    User.actives.resources.not_assigned_to(self.id)
#    return User.find_by_sql ["SELECT * FROM users
#                              WHERE not exists (select * from projects_users_joins where user_id = users.id AND project_id = ?)
#                                AND state_id = ?
#                              ORDER BY name, last_name", self.id, State.active.id]
  end

  def can_be_closed?
    #obtener el ultimo dashboard
    pd = self.project_dashboards.first
    return pd && pd.project_values && pd.project_values[:real_project_progress] >= 1
  end


  def check_for_destroy
    if !created?
      errors.add_to_base( I18n.t("screens.alerts.only_projects_in_state") + " " + ProjectState.find_by_i18n_name("created").name + " " + I18n.t("screens.alerts.can_be_destroyeds"))
      return false
    end
    return true
  end

  def copy_company_calendar
    #copiar days_off
    days_off = DayOff.where("company = ?", true)
    days_off.each do |day_of|
      project_day_off = day_of.clone
      project_day_off.company = false
      project_day_off.project_id = self.id
      project_day_off.save!
    end

    #copiar_holidays, solo los registros mayores a self.planned_start_date (los anteriores no sirven de nada)
    holidays = Holiday.where("company = ? and day >= ?", true, self.planned_start_date)
    holidays.each do |holiday|
      project_holiday = holiday.clone
      project_holiday.company = false
      project_holiday.project_id = self.id
      project_holiday.save!
    end
  end

  def set_before_update
    #si se cierra el projecto setear el real_end_date (seteralo solo si esta null, sino no porque ya se habia seteado)
    self.real_end_date = Date.today if !self.real_end_date && self.closed?
  end

  def get_days_off
    self.days_off.where("off = ?", true)
  end


  def planned_total_hours
    self.projects_phases_joins.sum(:planned_hours_phase)
  end

  def planned_progress(date = Date.today)
    planned_progress = 0.00
    self.projects_phases_joins.each do |projects_phases_join|
      planned_progress += Float(projects_phases_join.planned_hours_phase * projects_phases_join.planned_progress(date)) / self.planned_total_hours
    end
    return planned_progress
  end

  def real_progress(date = Date.today)
    real_progress = 0.00
    self.projects_phases_joins.each do |projects_phases_join|
      real_progress += Float(projects_phases_join.planned_hours_phase * projects_phases_join.real_progress(date)) / self.planned_total_hours
    end
    return real_progress
  end

  def planned_effort(date = Date.today)
    planned_effort = 0
    self.projects_phases_joins.each do |projects_phases_join|
      planned_effort += projects_phases_join.planned_effort(date)
    end
    return planned_effort
  end

  def real_effort(date = Date.today)
    real_effort = 0
    self.projects_phases_joins.each do |projects_phases_join|
      real_effort += projects_phases_join.real_effort(date)
    end
    return real_effort
  end

  def planned_cost(date = Date.today)
    planned_cost = 0.00
    self.projects_phases_joins.each do |projects_phases_join|
      planned_cost += projects_phases_join.planned_cost(date)
    end
    return planned_cost
  end

  def real_cost(date = Date.today)
    real_cost = 0.00
    self.projects_phases_joins.each do |projects_phases_join|
      real_cost += projects_phases_join.real_cost(date)
    end
    return real_cost
  end

  def cost_ev(date = Date.today) # Earned Value
    #real_progress(date) * planned_cost(date)
    ev = 0.00
    self.tasks.each do |task|
      task_ev = task.cost_ev(date)
      ev += task_ev
      #puts "&&&&&&&&&& Tarea: " + task.name + " EV:" + task_ev.to_s
      #puts "########## Tarea: " + task.name + " real_progress_now(date): " + task.real_progress_decimal(date).to_s + " // planned_cost_now(date): " + task.planned_cost_now(date).to_s + " // planned_effort_now(date): " + task.planned_effort_now(date).to_s
    end
    return ev
  end

  def cost_pv(date = Date.today) # Planned Value
    pv = 0.00
    self.tasks.each do |task|
      task_pv = task.cost_pv(date)
      pv += task_pv
      #puts "&&&&&&&&&& Tarea: " + task.name + " PV:" + task_pv.to_s
      #puts "########## Tarea: " + task.name + " planned_progress_now(date): " + task.planned_progress_now(date).to_s + " // planned_cost_now(date): " + task.planned_cost_now(date).to_s + " // planned_effort_now(date): " + task.planned_effort_now(date).to_s
    end
    return pv
  end

  def cost_ac(date = Date.today) # Actual Cost
    real_cost(date)
  end

  def hour_ev(date = Date.today) # Earned Value
    #real_progress(date) * planned_effort(date)
    ev = 0.00
    self.tasks.each do |task|
      task_ev = task.hour_ev(date)
      ev += task_ev
    end
    return ev
  end

  def hour_pv(date = Date.today) # Planned Value
    #planned_progress(date) * planned_effort(date)
    pv = 0.00
    self.tasks.each do |task|
      task_pv = task.hour_pv(date)
      pv += task_pv
      #puts "&&&&&&&&&& Tarea: " + task.name + " PV:" + task_pv.to_s
      #puts "########## Tarea: " + task.name + " planned_progress_now(date): " + task.planned_progress_now(date).to_s + " // planned_cost_now(date): " + task.planned_cost_now(date).to_s + " // planned_effort_now(date): " + task.planned_effort_now(date).to_s
    end
    return pv
  end

  def hour_ac(date = Date.today) # Actual Coast
    real_effort(date)
  end

=begin
Cálculo de PV (Planned Value):

PV= Avance Planeado Tarea x Costo Planeado de la Tarea

Cálculo de AC (Actual Cost):

AC = Costo Real de la Tareas agrupado por semana

=end

  def created?
    self.project_state == ProjectState.created
  end

  def in_progress?
    self.project_state == ProjectState.in_progress
  end

  def suspended?
    self.project_state == ProjectState.suspended
  end

  def canceled?
    self.project_state == ProjectState.canceled
  end

  def closed?
    self.project_state == ProjectState.closed
  end

  def has_any_progress?
    0 < TaskProgress.joins(:task).where("tasks.project_id = ? AND tasks.id = task_id", self.id).count
  end



  def to_ms_project_xml()
    xml = Builder::XmlMarkup.new
    xml.instruct!
    build_xml(xml)
  end

  private

  def create_leader
    self.projects_users_joins.create( :user_id => self.leader_id,
                                      :currency => self.currency,
                                      :hour_cost_in_project => self.leader.cost_hour_in_currency(self.currency),
                                      :leader => true,
                                      :state => State.active
                                    )
  end

  def update_leader
    puj = self.projects_users_joins.where("projects_users_joins.leader = ?", true).first
    if puj.user_id != self.leader_id
      puj.leader = false
      puj.save
      new_puj = self.projects_users_joins.where("projects_users_joins.user_id = ?", self.leader_id).first
      if new_puj
        new_puj.leader = true
        new_puj.state = State.active
        new_puj.save
      else
        create_leader
      end
    end
  end

  def build_xml(xml)
    #xml.tag!( "created-at", created_at, :type => :datetime)
    #xml.tag!( "updated-at", updated_at, :type => :datetime)
    xml.Project do
      xml.SaveVersion 12
      xml.UID id.to_s
      xml.Name name
      xml.StartDate planned_start_date.strftime("%y-%m-%dT%H:%M:%S")
      xml.FinishDate "12-07-27T00:00:00"
      #xml.FinishDate planned_end_date
      xml.DurationFormat 7 # 7 significa que la duracion se expresa en dias
      xml.WorkFormat 3 # signi fica que se expresa en dias (lo que no se si esto es "avance", ya lo veremos)

      xml.calendars do
        xml.calendar do
          xml.UID days_off.sum(:id)
          xml.Name "Project Caledar"
          xml.WeekDays do
            days_off.each do |day_off|
              xml.WeekDay do
                xml.DayType day_off.wday + 1
                xml.DayWorking day_off.off ? 0 : 1
              end
            end
          end
        end
      end

      xml.resources do
        users.each do |user|
          xml.resource do
            xml.UID user.id
            xml.name user.full_name
          end
        end
      end

      order_task = 0
      xml.Tasks do
        tasks.unscoped.where("project_id = ?", id).order("planned_start_date ASC").each do |task|
          order_task += 1
          xml.Task do
            xml.UID task.id + 1
            xml.ID order_task
            xml.name task.name
            xml.Start task.planned_start_date.strftime("%y-%m-%dT%H:%M:%S")
            xml.Finish task.planned_end_date.strftime("%y-%m-%dT%H:%M:%S")
            xml.Duration "PT" + (task.planned_duration * 8).to_s + "H0M0S" #asumiendo que el dia es de 8 horas esto deberia ser configurable por cada proyecto en su calendario
            xml.DurationFormat 7
            xml.PercentComplete task.real_progress_percent
          end
        end
      end
    end
  end

end
