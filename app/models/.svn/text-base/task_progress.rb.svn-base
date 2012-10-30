class TaskProgress < ActiveRecord::Base
  belongs_to :task

  validates_presence_of :effort, :progress, :working_day, :task_id
  validates_numericality_of :effort, :greater_than_or_equal_to => 1
  validates_numericality_of :progress

  before_save :check_before_save
  after_save :update_task_values, :update_project_state
  after_destroy :update_task_values_after_destroy

  def self.day_occupancy(date = Date.today)
    self.where("working_day = ?", date).sum(:effort)
  end
=begin
  def no_progress_after
    result = TaskProgress.where(:task_id => self.task_id).order("working_day DESC").limit(1)
    if result.first && result.first.working_day > self.working_day
      return false
    elsif result.first && result.first.working_day == self.working_day && result.first.id != self.id
      return false
    end

    return true
  end
=end

  def new_last_progress?
    self.task.get_last_progress.nil? || self.task.get_last_progress.working_day < self.working_day
  end

  def created_last_progress?
    self == self.task.get_last_progress
  end

  private ############################## PRIVATE ##############################

  def check_before_save
    if self.new_record?
      new_last_progress?
    else
      created_last_progress?
    end
  end


  def update_task_values
    #puede venir del destroy o no, de cualquier forma la task se updetea con la ultima task_progress existente
    task = self.task
    last_task_progress = task.get_last_progress #si viene del destroy no es la misma que self

    if task.task_progresses.count == 1
      task.real_start_date = last_task_progress.working_day
      task.task_state = TaskState.find_by_i18n_name("in_progress")
    end

    if self.progress == 100
      task.task_state = TaskState.find_by_i18n_name("closed")
      task.real_end_date = last_task_progress.working_day
      task.real_duration = Holiday.how_many_working_days(task.real_start_date, (last_task_progress.working_day), self.task.project_id)
    end

    #task.real_hours = TaskProgress.sum(:effort, :conditions => ['task_id = ?', task.id])  #@task_progress.effort
    task.real_hours = task.task_progresses.sum(:effort)
    task.real_progress =  last_task_progress.progress
    task.save(false) # save(false) hace que no se ejecuten las validaciones de Task (me daba un error porque se superaban las horas de la fase, si estuvieran bien los datos no daria esto)
  end

  def update_task_values_after_destroy
    task = self.task
    if task.get_last_progress.nil?
      #viene del destroy y se ha deleteado todas las task_progress
      task.task_state = TaskState.find_by_i18n_name("assigned")
      task.real_start_date = nil
      task.real_end_date = nil
      task.real_progress =  nil
      task.real_hours = nil
      task.real_duration = nil
      #todo: hay que setear mas valores como real_cost, fijarse todos los que faltan
      task.save(false) # save(false) hace que no se ejecuten las validaciones de Task (me daba un error porque se superaban las horas de la fase, si estuvieran bien los datos no daria esto)
    elsif
      update_task_values
    end
  end

  def update_project_state
    if self.task.project.created?
      self.task.project.project_state = ProjectState.in_progress
      self.task.project.real_start_date = self.working_day
      self.task.project.save
    end
  end

end
