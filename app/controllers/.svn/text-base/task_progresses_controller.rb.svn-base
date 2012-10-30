class TaskProgressesController < ApplicationController
  layout nil
  load_and_authorize_resource

  # GET /task_progresses
  # GET /task_progresses.xml
  def index
  end

  # GET /task_progresses/1
  # GET /task_progresses/1.xml
  def show
    @task_progress = TaskProgress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task_progress }
    end
  end

  # GET /task_progresses/new
  # GET /task_progresses/new.xml
  def new
    #@task_progress = TaskProgress.new

    @task_progress.task_id = params['task_id'].to_i
    @task_progress.working_day = DateTime.strptime(params['working_day'], "%d/%m/%Y").to_date

    @fields_disabled = false
    if !@task_progress.new_last_progress?
      @fields_disabled = true
      flash[:alert] = "Existen avances posteriores a esta fecha"
    elsif @task_progress.task.task_closed?
      @fields_disabled = true
      flash[:alert] = "La tarea esta cerrada"
    elsif @task_progress.working_day > Date.today
      @fields_disabled = true
      flash[:alert] = "No se puede cargar avances para dias futuros"
    elsif !Holiday.working_day?(session[:actual_project], @task_progress.working_day)
      @fields_disabled = true
      flash[:alert] = "No se puede cargar avances para dias no laborables"
    end

    last_progress = @task_progress.task.get_last_progress

    if last_progress
      @task_progress.progress = last_progress.progress
      @task_progress.effort = last_progress.effort
    else
      @task_progress.progress = 0
      @task_progress.effort = 0
    end


    respond_to do |format|
      format.html # new.html.erb
      #format.js { render_to_facebox :msg => "pindonga" }
      format.xml  { render :xml => @task_progress }
    end
  end

  # GET /task_progresses/1/edit
  def edit
    @task_progress = TaskProgress.find(params[:id])

    @edit_mode = true
    @fields_disabled = false
    if !@task_progress.created_last_progress?
      @fields_disabled = true
      flash[:info] = "Solo lectura por existir avances posteriores"
    elsif @task_progress.task.task_closed?
      @fields_disabled = true
      flash[:alert] = "La tarea esta cerrada"
    else
      flash[:info] = "Modo edición de avance"
      @destroyable = true
    end

  end

  # POST /task_progresses
  # POST /task_progresses.xml
  def create
    split_effort_and_progress
    @task_progress = TaskProgress.new(params[:task_progress])
    if !params[:lesson].blank?
      lesson = Lesson.new(:description => params[:lesson], :user => current_user, :life_cycle_phase => @task_progress.task.life_cycle_phase, :project => @task_progress.task.project )
      lesson.save
    end

    respond_to do |format|
      if @task_progress.save
        #update_task_values

        format.html { redirect_to(progress_tasks_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @task_progress, :status => :created, :location => @task_progress }
      else
        format.html { redirect_to "/tasks/progress", :alert => t("screens.alerts.task_progress_not_saved") + ": " + @task_progress.errors.full_messages.join(". ") } #"El avance no se ha grabado, probablemente por haber avances posteriores a esta fecha" }
        format.xml  { render :xml => @task_progress.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /task_progresses/1
  # PUT /task_progresses/1.xml
  def update
    split_effort_and_progress
    @task_progress = TaskProgress.find(params[:id])

    respond_to do |format|
      if @task_progress.update_attributes(params[:task_progress])
        #update_task_values

        format.html { redirect_to(progress_tasks_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { redirect_to "/tasks/progress", :alert => "El avance no se ha actualizado, probablemente por haber avances posteriores a esta fecha" }
        format.xml  { render :xml => @task_progress.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /task_progresses/1
  # DELETE /task_progresses/1.xml
  def destroy
    @task_progress = TaskProgress.find(params[:id])
    @task_progress.destroy

    #hay que updetear los valores de la task, para ello se recupera la ultima task_progress, si es null el metodo update_task_values lo sabe manejar
    #@task = @task_progress.task
    #@task_progress = @task_progress.task.get_last_progress
    #update_task_values

    respond_to do |format|
      format.html { redirect_to(progress_tasks_path) }
      format.xml  { head :ok }
    end
  end



  private ############################# PRIVATE #################################

  def split_effort_and_progress
    params[:task_progress][:effort] = params[:task_progress][:effort].split(" ")[0]
    params[:task_progress][:progress] = params[:task_progress][:progress].split("%")[0]
  end


=begin
  def update_task_values
    if @task_progress.nil?
      #viene del destroy y se ha deleteado todas las task_progress
      @task.task_state = TaskState.find_by_i18n_name("assigned")
      @task.real_start_date = nil
      @task.real_end_date = nil
      @task.real_progress =  nil
      @task.real_hours = nil
      @task.real_duration = nil

      @task.save!
    elsif #puede venir del destroy o no, de cualquier forma la task se updetea con la ultima task_progress existente
      task = @task_progress.task

      if task.task_progresses.count == 1
        task.real_start_date = @task_progress.working_day
        task.task_state = TaskState.find_by_i18n_name("in_progress")
      end

      if @task_progress.progress == 100
        task.task_state = TaskState.find_by_i18n_name("closed")
      end

      task.real_progress =  @task_progress.progress
      task.real_hours = TaskProgress.sum(:effort, :conditions => ['task_id = ?', task.id])  #@task_progress.effort
      task.real_duration = (@task_progress.working_day + 1) - task.real_start_date
      task.save!
    end
  end
=end

end

