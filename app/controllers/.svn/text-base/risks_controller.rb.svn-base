class RisksController < ApplicationController
  load_and_authorize_resource :except => [:index, :ajax_calculate_risk_exposition]
  skip_authorization_check    :only   => [:index, :ajax_calculate_risk_exposition]


  before_filter :set_action_source_type

  # GET /risks
  # GET /risks.xml
  def index
    @risks = do_index(Risk, params, true)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risks }
    end
  end

  # GET /risks/1
  # GET /risks/1.xml
  def show
    #@risk = Risk.find(params[:id])

    search_algoritm
    @search = @risk.accions.search(params[:search])
    @accions = @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk }
    end
  end

  # GET /risks/new
  # GET /risks/new.xml
  def new
    @risk.project_id = session[:actual_project]
    @risk.user = current_user
    @risk.detection_date = Date.today
    @risk.risk_state = RiskState.find_by_i18n_name("open")

    if params[:risk_goto]
      session[:risk_goto] = params[:risk_goto]
      #@risk.risk_source_id = RiskSource.find_by_name("Reporte").id #TODO: esta tabla no tiene i18n_name, pero necesito hacer negocio, que hago?
    else
      session[:risk_goto] = nil
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk }
    end
  end

  # GET /risks/1/edit
  def edit

    if params[:risk_goto]
      session[:risk_goto] = params[:risk_goto]
    else
      session[:risk_goto] = nil
    end

    if @risk.closed?
      flash[:info] = t("screens.alerts.edit_not_allowed_because_closed")
      redirect_to(risks_path)
    end
  end

  # POST /risks
  # POST /risks.xml
  def create

    @risk.accions.each do |accion|
      accion.creating_from_risk = true #para que no valide la precencia de risk_id en la accion
    end

    respond_to do |format|
      if @risk.save
        format.html { redirect_to(session[:risk_goto] ? session[:risk_goto] : risks_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @risk, :status => :created, :location => @risk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risks/1
  # PUT /risks/1.xml
  def update

    respond_to do |format|
      if @risk.update_attributes(params[:risk])
        format.html { redirect_to(session[:risk_goto] ? session[:risk_goto] : risks_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risks/1
  # DELETE /risks/1.xml
  def destroy
    prudent_destroy(Risk.find(params[:id]))
  end

  def ajax_calculate_risk_exposition
    @risk = Risk.new
    @risk.risk_probability_id = params[:risk][:risk_probability_id]
    @risk.risk_impact_id = params[:risk][:risk_impact_id]
    @risk.calculate_values
  end

  ############################ PRIVATE ###############################
  private

  def set_action_source_type
    @action_source_type = ActionSourceType.find_by_i18n_name("risk")
  end


end
