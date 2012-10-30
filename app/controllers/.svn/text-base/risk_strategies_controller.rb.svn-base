class RiskStrategiesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /risk_strategies
  # GET /risk_strategies.xml
  def index
    @risk_strategies = do_index(RiskStrategy, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risk_strategies }
    end
  end

  # GET /risk_strategies/1
  # GET /risk_strategies/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk_strategy }
    end
  end

  # GET /risk_strategies/new
  # GET /risk_strategies/new.xml
  def new
    @risk_strategy.state = State.active

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_strategy }
    end
  end

  # GET /risk_strategies/1/edit
  def edit
  end

  # POST /risk_strategies
  # POST /risk_strategies.xml
  def create

    @risk_strategy.user = current_user

    respond_to do |format|
      if @risk_strategy.save
        format.html { redirect_to(risk_strategies_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @risk_strategy, :status => :created, :location => @risk_strategy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_strategy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_strategies/1
  # PUT /risk_strategies/1.xml
  def update
    if params[:risk_strategy][:risk_source_ids].blank?
      @risk_strategy.risk_source_ids = params[:risk_strategy][:risk_source_ids] #esto se debe al bug del jquery plugin, que si se deseleciona completo no viaja el parametro, haciendo que no se actualice
    end
    respond_to do |format|
      if @risk_strategy.update_attributes(params[:risk_strategy])
        format.html { redirect_to(risk_strategies_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_strategy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_strategies/1
  # DELETE /risk_strategies/1.xml
  def destroy
    prudent_destroy(RiskStrategy.find(params[:id]))
  end
end
