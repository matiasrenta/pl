class TasksController < ApplicationController
  load_and_authorize_resource :except => [:index, :report, :ajax_display_planned_end_date]
  skip_authorization_check    :only   => [:index, :report, :ajax_display_planned_end_date]

  before_filter :expand_phase, :only => [:show, :create, :update, :destroy]

  # GET /tasks
  # GET /tasks.xml
  def index
    if params[:search]
      delocalize_dates([:planned_start_date_greater_than_or_equal_to, :planned_start_date_less_than_or_equal_to,
                        :real_start_date_greater_than_or_equal_to, :real_start_date_less_than_or_equal_to,
                        :planned_end_date_greater_than_or_equal_to, :planned_end_date_less_than_or_equal_to,
                        :real_end_date_greater_than_or_equal_to, :real_end_date_less_than_or_equal_to
                       ])
      integerize_money([:planned_cost_cents_greater_than_or_equal_to, :planned_cost_cents_less_than_or_equal_to,
                        :real_cost_cents_greater_than_or_equal_to, :real_cost_cents_less_than_or_equal_to
                       ])
    end

    @tasks = do_index(Task, params, true, true, false)
    @project = actual_project

    if params[:gantt_view]
      session[:gantt_view] = true
    else
      session[:gantt_view] = nil
    end

    session[:date_for_availability] = Date.new(params[:year_availability].to_i, params[:month_availability].to_i, 1) if params[:year_availability]
    @report_date = session[:date_for_availability] ? session[:date_for_availability] : Date.today
    @days_off_numbers = DayOff.days_off_numbers_in_month(@report_date, @project.id)
    session[:date_for_availability] = nil
    @matrix = User.availability(@report_date, @project)
    @days = (@report_date.end_of_month - @report_date.beginning_of_month).to_i + 1

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task.project = actual_project
    @task.task_state = TaskState.assigned
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @tasks }
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    respond_to do |format|
      if @task.save
        TaskMailer.task_created(@task).deliver
        format.html {
          message = t("screens.notice.successfully_created") + ". " + t("screens.notice.mail_sent_to_user", :user_name => @task.user.full_name, :user_email => @task.user.email)
          session[:gantt_view] ? redirect_to(tasks_path(:gantt_view => true), :notice => message) : redirect_to(tasks_path, :notice => message)
        }
        format.xml { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render(:action => "new")}
        format.xml { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task.attributes = params[:task]
    @task.currency = params[:task][:currency]

    respond_to do |format|
      if @task.save
        TaskMailer.task_updated(@task).deliver
        message = t("screens.notice.successfully_updated") + ". " + t("screens.notice.mail_sent_to_user", :user_name => @task.user.full_name, :user_email => @task.user.email)
        format.html { redirect_to(tasks_path, :notice => message) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    prudent_destroy(@task)
=begin
    task = Task.find(params[:id])
    if task.destroyable?([:children]) #le paso :children porque es una excepcion, es decir, no la toma en cuenta para ver si se puede borrar
      task.destroy
      task.children.delete_all #no borra los registros sino que pone a NULL la foreign key. NO SE PUEDE poner :dependent => :delete_all porque esto SI deletea los registros
    else
      flash[:warning] = task.errors.full_messages if task.errors.any?
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml { head :ok }
    end
=end
  end


  def progress
    set_content_title([t("screens.menu.proj.progress_task")])

    if params[:search]
      delocalize_dates([:planned_start_date_greater_than_or_equal_to, :planned_start_date_less_than_or_equal_to,
                        :real_start_date_greater_than_or_equal_to, :real_start_date_less_than_or_equal_to,
                        :planned_end_date_greater_than_or_equal_to, :planned_end_date_less_than_or_equal_to
                       ])
    end

    if actual_project.leader == current_user && !params[:search]
      #no se ha hecho click en filtrar ni en limpiar filtro, entonces seteo el recurso al lider, es decir, al current_user. Solo puedo setear a recursos del proyecto porque es lo unico que hay en el combo
      params[:search] = Hash.new
      params[:search] = {:user_id_equals => current_user.id}
    end

    search_algoritm
    @search = actual_project.tasks.where("task_state_id IN (?)", [TaskState.assigned, TaskState.in_progress, TaskState.delayed]).accessible_by(current_ability, :read).search(params[:search])
    @tasks = @search.all
    #@tasks = @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
    @holidays = Holiday.where("project_id = ?", session[:actual_project]).order("day")

    @days_off_for_fullcalendar = DayOff.calendar_wday_classes(session[:actual_project])
    @holidays_for_fullcalendar = @holidays.map(&:milis_from_1970).join(', ')

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @tasks }
    end
  end

  def report
    set_content_title([t("screens.labels.tasks_report")])
    @tasks = do_index(Task, params, true, true, true)
  end

  def task_progresses_list
    @task = Task.find(params[:id])
  end


  def ajax_display_planned_end_date
    @task = Task.new(params[:task])
    @task.calculate_planned_end_date if @task.validates_numericality_of(:planned_duration) && @task.validates_presence_of(:planned_start_date)
    @task.calculate_planned_hours if @task.validates_numericality_of(:planned_duration)
  end


  private ##########################################

  def expand_phase
    session[:expand_phase_id] = @task.life_cycle_phase_id
  end

end
