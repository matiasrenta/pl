class ProjectDashboardsController < ApplicationController

  load_and_authorize_resource :except => :index

  # GET /project_dashboards
  # GET /project_dashboards.xml
  def index
    params[:search] = nil if params[:search_clear]
    delocalize_dates([:at_date_greater_than_or_equal_to, :at_date_less_than_or_equal_to]) if params[:search]
    search_algoritm
    @search = ProjectDashboard.select("id, status_report, user_id, description, at_date, created_at").where("project_id = ?", session[:actual_project]).accessible_by(current_ability, :fetch).search(params[:search])
    @project_dashboards = @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_dashboards }
    end
  end

  # GET /project_dashboards/1
  # GET /project_dashboards/1.xml
  def show
    #@project_dashboard = ProjectDashboard.find(params[:id])
    @project_dashboard.regenerate_associated_models

    @project = @project_dashboard.project
    @phase_progress_hours_cost = @project_dashboard.phases_values

    @planned_project_progress = @project_dashboard.project_values[:planned_project_progress]
    @real_project_progress    = @project_dashboard.project_values[:real_project_progress]
    @planned_project_effort   = @project_dashboard.project_values[:planned_project_effort]
    @real_project_effort      = @project_dashboard.project_values[:real_project_effort]
    @planned_project_cost     = @project_dashboard.project_values[:planned_project_cost]
    @real_project_cost        = @project_dashboard.project_values[:real_project_cost]

    @progress_deviation = @project_dashboard.deviation_values[:progress_deviation]
    @effort_deviation   = @project_dashboard.deviation_values[:effort_deviation]
    @cost_deviation     = @project_dashboard.deviation_values[:cost_deviation]


    #@search = Risk.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :fetch).search(params[:search])
    #@search_accions = Accion.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :fetch).search(params[:search])
    #@search_problems = Problem.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :fetch).search(params[:search])

    @risks    = @project_dashboard.risks
    @accions  = @project_dashboard.accions
    @problems = @project_dashboard.problems

    if @project_dashboard.ev_values
      @acev = @project_dashboard.ev_values[:acev]
      @acpv = @project_dashboard.ev_values[:acpv]
      @acac = @project_dashboard.ev_values[:acac]
      @ahev = @project_dashboard.ev_values[:ahev]
      @ahpv = @project_dashboard.ev_values[:ahpv]
      @ahac = @project_dashboard.ev_values[:ahac]

      @ev_charts_big = @project_dashboard.ev_values[:ev_charts_big]

      @c_cpi = @project_dashboard.ev_values[:c_cpi]
      @h_cpi = @project_dashboard.ev_values[:h_cpi]

      @c_spi = @project_dashboard.ev_values[:c_spi]
      @h_spi = @project_dashboard.ev_values[:h_spi]

      @c_projection_text = @project_dashboard.ev_values[:c_projection_text]
      @h_projection_text = @project_dashboard.ev_values[:h_projection_text]

      #solo se puede crear o editar un status report si es el tablero de HOY
      @can_create_edit = @project_dashboard.at_date == Date.today
    end


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_dashboard }
    end
  end

  # GET /project_dashboards/new
  # GET /project_dashboards/new.xml
  def new
    #@project_dashboard = ProjectDashboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_dashboard }
    end
  end

  # GET /project_dashboards/1/edit
  def edit
    @project_dashboard = ProjectDashboard.find(params[:id])
  end

  # POST /project_dashboards
  # POST /project_dashboards.xml
  def create
    #@project_dashboard = ProjectDashboard.new(params[:project_dashboard])
    if @project_dashboard.at_date.future?
      @project_dashboard.errors.add(:at_date, "No puede ser en el futuro")
      render :action => "new"
    else
      if params[:regenerate] #esto es si viene del link del warning cuando no se ha generado un nuevo reporte sino que se muestra uno ya creado
        @project_dashboard = ProjectDashboard.new
        @project_dashboard.project = actual_project
        @project_dashboard.at_date = params[:at_date]
        @project_dashboard.generate(@project_dashboard.at_date)
        if @project_dashboard.save
          redirect_to(@project_dashboard, :notice => t("screens.notice.successfully_created"))
        else
          format.html { render :action => "new" }
        end
      else

        @project_dashboard.project = actual_project

        #fijarse si hay uno de la misma fecha, cargar ese con un mensaje warning que diga "Mostrando reporte generado anteriormente para esta fecha. Regenerar Reporte"
        project_dashboard_saved = ProjectDashboard.where("at_date = ? && project_id = ?", @project_dashboard.at_date, actual_project.id).order("created_at DESC").first
        if project_dashboard_saved
          @project_dashboard = project_dashboard_saved
          flash[:warning] = "Mostrando reporte generado anteriormente para esta fecha. #{view_context.link_to('Regenerar datos', {:controller => "project_dashboards", :action => "create", :regenerate => true, :at_date => @project_dashboard.at_date}, :method => :post)}".html_safe
          redirect_to(@project_dashboard)
        else
          @project_dashboard.generate(@project_dashboard.at_date)
          if @project_dashboard.save
            redirect_to(project_dashboard_path(@project_dashboard.id), :notice => t("screens.notice.successfully_created"))
          else
            render :action => "new"
          end
        end
      end
    end
  end

  # PUT /project_dashboards/1
  # PUT /project_dashboards/1.xml
  def update
    #@project_dashboard = ProjectDashboard.find(params[:id])

    respond_to do |format|
      if @project_dashboard.update_attributes(params[:project_dashboard])
        format.html { redirect_to(@project_dashboard, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_dashboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_dashboards/1
  # DELETE /project_dashboards/1.xml
  def destroy
    #@project_dashboard = ProjectDashboard.find(params[:id])
    @project_dashboard.destroy

    respond_to do |format|
      format.html { redirect_to(project_dashboards_url) }
      format.xml  { head :ok }
    end
  end

end
