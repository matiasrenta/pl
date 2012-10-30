class ProjectsPhasesJoin < ActiveRecord::Base
  belongs_to :project
  belongs_to :life_cycle_phase

  #attr_accessible :planned_hours_phase, :project_id, :life_cycle_phase_id, :planned_start_date, :planned_end_date

  validates_presence_of :planned_hours_phase, :planned_start_date, :planned_end_date
  validates_numericality_of :planned_hours_phase, :greater_than => 0
  validate :validate_start_and_end_dates

  def planned_total_hours()
    self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase_id).sum(:planned_hours)
  end


  def planned_progress(date = Date.today)
    #return 1.00 if date > self.planned_end_date #todo: tal vez se use pero no sabemos, si quitamos la fecha inicio-fin de la fase
    planned_phase_progress = 0.00
    self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase_id).each do |task|
      planned_phase_progress += Float(task.planned_effort_now(date)) / self.planned_hours_phase
    end
    return 1.00 if planned_phase_progress > 1
    planned_phase_progress
  end

  def planned_effort(date = Date.today)
    planned_effort = 0
    self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase_id).each do |task|
      planned_effort += task.planned_effort_now(date)
    end
    return planned_effort
  end

  def planned_cost(date = Date.today)
    planned_cost = 0.00
    self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase_id).each do |task|
      planned_cost += task.planned_cost_now(date)
    end
    return planned_cost
  end

  def real_progress(date = Date.today)
    real_phase_progress = 0.00
    self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase_id).each do |task|
      real_phase_progress += task.planned_hours * task.real_progress_decimal(date) / self.planned_hours_phase
    end
    return real_phase_progress
  end

  def real_effort(date = Date.today)
    real_phase_effort = 0
    self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase_id).each do |task|
      real_phase_effort += task.real_effort_now(date)
    end
    return real_phase_effort
  end

  def real_cost(date = Date.today)
    real_phase_cost = 0.00
    self.project.tasks.where("life_cycle_phase_id = ?", self.life_cycle_phase_id).each do |task|
      real_phase_cost += task.real_cost_now(date)
    end
    return real_phase_cost
  end


  private

  def validate_start_and_end_dates
    if self.planned_start_date && self.planned_end_date
      errors.add(:planned_end_date, I18n.t("screens.alerts.must_be_greater_than_initial")) unless planned_end_date > planned_start_date
      return false

      #valida que la fecha de fin no sea mas chica que la fecha de fin de la ultima tarea del gantt (para esta fase)
      tasks = self.project.tasks.where("life_cycle_phase_id = ? && task_state_id <> ?", self.life_cycle_phase_id, TaskState.canceled)
      if tasks.count > 0 && tasks.maximum(:planned_end_date) > self.planned_end_date
        errors.add(:planned_end_date, I18n.t("screens.alerts.tasks_with_bigger_end", :date => tasks.maximum(:planned_end_date)))
        return false
      end
    end
    return true
  end


end
