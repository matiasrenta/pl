class ProblemsController < ApplicationController
  load_and_authorize_resource :except => [:index]
  skip_authorization_check    :only   => [:index]

  before_filter :set_action_source_type

  # GET /problems
  # GET /problems.xml
  def index
    @problems = do_index(Problem, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @problems }
    end
  end

  # GET /problems/1
  # GET /problems/1.xml
  def show

    search_algoritm
    @search = @problem.accions.search(params[:search])
    @accions = @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem }
    end
  end

  # GET /problems/new
  # GET /problems/new.xml
  def new
    @problem.user_id = current_user.id
    @problem.project_id = session[:actual_project]
    @problem.problem_state = ProblemState.find_by_i18n_name("open")

    if params[:problem_goto]
      session[:problem_goto] = params[:problem_goto]
      #problem no tiene source_type, por eso no puedo setear el source_type = Reporte
    else
      session[:problem_goto] = nil
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @problem }
    end
  end

  # GET /problems/1/edit
  def edit
    if params[:problem_goto]
      session[:problem_goto] = params[:problem_goto]
    else
      session[:problem_goto] = nil
    end

    if @problem.closed?
      flash[:info] = t("screens.alerts.edit_not_allowed_because_closed")
      redirect_to(problems_path)
    end

  end

  # POST /problems
  # POST /problems.xml
  def create
    @problem.accions.each do |accion|
      accion.creating_from_problem = true #para que no valide la precencia de problem_id en la accion
    end

    respond_to do |format|
      if @problem.save
        format.html { redirect_to(session[:problem_goto] ? session[:problem_goto] : problems_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @problem, :status => :created, :location => @problem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /problems/1
  # PUT /problems/1.xml
  def update
    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to(session[:problem_goto] ? session[:problem_goto] : problems_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.xml
  def destroy
    prudent_destroy(Problem.find(params[:id]))
  end


  ########################### PRIVATE ######################################
  private

  def set_action_source_type
    @action_source_type = ActionSourceType.find_by_i18n_name("problem")
  end

end
