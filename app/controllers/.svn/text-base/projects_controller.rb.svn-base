class ProjectsController < ApplicationController
  load_and_authorize_resource :except => [:index, :gantt, :ajax_display_phases_form]
  skip_authorization_check    :only   => [:index, :gantt, :ajax_display_phases_form]

  #before_filter :set_actual_project,     :only => [:show, :edit]           #para cambiar el combo de arriba tambien
  skip_before_filter :set_actual_project, :only => [:show, :new, :edit]
  before_filter :set_actual_project_in_project_controller, :only => [:show, :edit]
  before_filter :nullify_actual_project, :only => [:new] #para cambiar el combo de arriba tambien
  after_filter :nullify_actual_project, :only => [:destroy] #para cambiar el combo de arriba tambien

  # GET /projects
  # GET /projects.xml

  def index
    #todo: poner delocalize_dates e integerize_money en todas las pantallas de filtros que lo necesiten
    if params[:search]
      delocalize_dates([:planned_start_date_greater_than_or_equal_to, :planned_start_date_less_than_or_equal_to,
                        :planned_end_date_greater_than_or_equal_to, :planned_end_date_less_than_or_equal_to,
                        :real_end_date_greater_than_or_equal_to, :real_end_date_less_than_or_equal_to,
                        :real_start_date_greater_than_or_equal_to, :real_start_date_less_than_or_equal_to])

      integerize_money([:sale_price_cents_greater_than_or_equal_to, :sale_price_cents_less_than_or_equal_to,
                        :risk_fund_cents_greater_than_or_equal_to, :risk_fund_cents_less_than_or_equal_to,
                        :expense_fund_cents_greater_than_or_equal_to, :expense_fund_cents_less_than_or_equal_to])
    end

    @projects = do_index(Project, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    #@project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project.project_state = ProjectState.find_by_i18n_name("created")
    @project.hours_day = DayHour.first.hours
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    #@project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project.currency = params[:project][:currency] #si no lo pongo expilicitamente queda en USD, no se por que
    respond_to do |format|
      if @project.save
        format.html { redirect_to(project_path(@project), :notice => t("screens.notice.successfully_created")) }
        format.xml { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end


# PUT /projects/1
# PUT /projects/1.xml
  def update
    #lo seteo porque esta deshabilitado en la pantalla, pero no deberia hacer falta, ya que @project lo tiene, pero como no me funciona el currency lo tengo que hacer asi
    #(update al comment de arriba: puse un hidden :currency en el form para que siempre viaje)
    #params[:project][:currency]= @project.currency #todo: nunca pude hacer funcionar currency en Project, no se por que pero debo seterar despues del update_attributes el currency en el @project

    #debo borrar los PPJs existentes y grabar los nuevos, esto es un kilombo por eso lo debo hacer a mano
    @project.projects_phases_joins.clear if params[:remove_ppjs_in_update_flag]

    @project.attributes = params[:project]
    @project.currency = params[:project][:currency]

    respond_to do |format|
      if @project.save #@project.update_attributes(params[:project])
        #@project.currency = params[:project][:currency]
        #@project.save
        format.html { redirect_to(@project, :notice => t("screens.notice.successfully_updated")) }
        format.xml { head :ok }
      else
        @project.currency = params[:project][:currency]
        format.html { render :action => "edit" }
        format.xml { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end


# DELETE /projects/1
# DELETE /projects/1.xml
  def destroy
    if @project.check_for_destroy
      prudent_destroy(@project)
    else
      flash[:warning] = @project.errors.full_messages if @project.errors.any?
      respond_to do |format|
        format.html { redirect_to(:back) }
        format.xml { head :ok }
      end
    end
  end

  def ajax_display_phases_form
    if params[:project_id].blank?
      @project = Project.new(params[:project])
      @project.project_state = ProjectState.find_by_i18n_name("created")
      @project.currency = params[:project][:currency]
      @project.projects_phases_joins.clear
    else
      @project = Project.find(params[:project_id])
      @project.attributes = params[:project]
      @project.currency = params[:project][:currency]
      #@project.projects_phases_joins.clear #no puedo hacer clear porque los borra de la bbdd, debo hacer que pinte el nuevo form, luego en el update los borro y grabo los PPJs nuevos
      @remove_ppjs_in_update_flag = true
    end
  end

  def gantt
    @project = actual_project
    @phases = @project.life_cycle.life_cycle_phases
    #@tasks = @project.tasks.unscoped.where("project_id = ?", session[:actual_project]).order("life_cycle_phase_id ASC, planned_start_date ASC").accessible_by(current_ability, :fetch)
  end


  private

  def set_actual_project_in_project_controller
    current_user.last_project_viewed = @project
    current_user.save
    session[:actual_project] = @project.id
    set_projects
  end

  def nullify_actual_project
    return if @project.destroyed? && @project.id != session[:actual_project]
    current_user.last_project_viewed_id = nil
    current_user.save
    session[:actual_project] = nil
    set_projects
  end

end
