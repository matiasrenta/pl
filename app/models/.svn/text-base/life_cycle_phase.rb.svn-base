class LifeCyclePhase < ActiveRecord::Base
  #default_scope order("position ASC")

  belongs_to :life_cycle

  has_many :tasks
  has_many :projects_phases_joins
  has_many :projects, :through => :projects_phases_joins
  has_many :lessons
  has_many :risks

  validates_presence_of :name, :position#, :life_cycle
  validates_numericality_of :position, :greater_than => 0
  validates_uniqueness_of :position, :scope => :life_cycle_id

  scope :phases_of_life_cycle, lambda {|life_cycle| where("life_cycle_phases.life_cycle_id = ?", life_cycle)}

  def planned_total_hours(project_id)
    self.tasks.where("project_id = ?", project_id).sum(:planned_hours)
  end

  def planned_progress(project_id, date = Date.today)
    planned_phase_progress = 0.00
    tasks = self.tasks.where("project_id = ? and planned_start_date < ?", project_id, date) #todo: ver en que estado debe estar la tarea, la cancelada debe tratarse especialmente
    tasks.each do |task|
      planned_phase_progress += Float(task.planned_effort_now) / Float(self.planned_total_hours(project_id))
    end
    return planned_phase_progress * 100
  end

  def planned_effort(project_id, date = Date.today)
    planned_effort = 0
    tasks = self.tasks.where("project_id = ? and planned_start_date < ?", project_id, date)
    tasks.each do |task|
      planned_effort += task.planned_effort_now
    end
    return planned_effort
  end

  def planned_cost(project_id, date = Date.today)
    planned_cost = 0.00
    tasks = self.tasks.where("project_id = ? and planned_start_date < ?", project_id, date)
    tasks.each do |task|
      planned_cost += task.planned_cost_now
    end
    return planned_cost
  end

  def real_progress(project_id, date = Date.today)
    real_phase_progress = 0
    tasks = self.tasks.where("project_id = ? and real_progress > ?", project_id, 0)
    tasks.each do |task|
      real_phase_progress += task.planned_hours * task.real_progress_percent(date) / self.planned_total_hours(project_id)
    end
    return real_phase_progress
  end

  def real_effort(project_id, date = Date.today)
    real_phase_effort = 0
    tasks = self.tasks.where("project_id = ? and real_hours > ?", project_id, 0) #la condicion de real_hour no sirve, la que realmente sirve es la que tiene task.real_effort_now, ese metodo suma las horas solo de las tareas hasta esa fecha
    tasks.each do |task|
      real_phase_effort += task.real_effort_now(date)
    end
    return real_phase_effort
  end

  def real_cost(project_id, date = Date.today)
    real_phase_cost = 0.00
    tasks = self.tasks.where("project_id = ? and real_hours > ?", project_id,  0) #idem al comentario del metodo real_effort
    tasks.each do |task|
      real_phase_cost += task.real_cost_now(date)
    end
    return real_phase_cost
  end

end
