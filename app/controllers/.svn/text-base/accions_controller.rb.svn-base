class AccionsController < ApplicationController
  load_and_authorize_resource :except => [:index, :ajax_display_risk_or_problem]
  skip_authorization_check    :only   => [:index, :ajax_display_risk_or_problem]
  skip_authorize_resource :only => :new


  # GET /accions
  # GET /accions.xml

  def index
    @accions = do_index(Accion, params, true)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accions }
    end
  end

  # GET /accions/1
  # GET /accions/1.xml
  def show
    #@accion = Accion.find(params[:id])

    search_algoritm
    @search = @accion.action_trackings.search(params[:search])
    @action_trackings = @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @accion }
    end
  end

  # GET /accions/new
  # GET /accions/new.xml
  def new
    @accion.project = actual_project
    @accion.action_state = ActionState.open
    authorize! :new, @accion

    if params[:accion_goto]
      session[:accion_goto] = params[:accion_goto]
      @accion.action_source_type_id = ActionSourceType.find_by_i18n_name("report").id
    else
      session[:accion_goto] = nil
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @accion }
    end
  end

  # GET /accions/1/edit
  def edit
    #@accion = Accion.find(params[:id])

    if params[:accion_goto]
      session[:accion_goto] = params[:accion_goto]
    else
      session[:accion_goto] = nil
    end
  end

  # POST /accions
  # POST /accions.xml
  def create
    #@accion = Accion.new(params[:accion])
    #@accion.responsible_user_id = params[:accion][:responsible_user_id] #no se por que, pero si no pongo esta linea no se setea el responsable

    respond_to do |format|
      if @accion.save
        format.html { redirect_to(session[:accion_goto] ? session[:accion_goto] : accions_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @accion, :status => :created, :location => @accion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @accion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accions/1
  # PUT /accions/1.xml
  def update
    #@accion = Accion.find(params[:id])

    respond_to do |format|
      if @accion.update_attributes(params[:accion])
        format.html { redirect_to(session[:accion_goto] ? session[:accion_goto] : accions_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @accion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accions/1
  # DELETE /accions/1.xml
  def destroy
    prudent_destroy(Accion.find(params[:id]))
  end

  #si se elige como fuente de la accion "risk" or "problem" debe mostrar el dropdown de risk or problem
  def ajax_display_risk_or_problem
    accion_source_type = params[:accion][:action_source_type_id]
    if params[:accion][:action_source_type_id] == ""
      #do nothing
    elsif ActionSourceType.find(accion_source_type).i18n_name == "problem"
      @problem = true
    elsif ActionSourceType.find(accion_source_type).i18n_name == "risk"
      @risk = true
    end
  end
end
