class RiskStatesController < ApplicationController
  # GET /risk_states
  # GET /risk_states.xml
  def index
    @risk_states = do_index(RiskState, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risk_states }
    end
  end

  # GET /risk_states/1
  # GET /risk_states/1.xml
  def show
    @risk_state = RiskState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk_state }
    end
  end

  # GET /risk_states/new
  # GET /risk_states/new.xml
  def new
    @risk_state = RiskState.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_state }
    end
  end

  # GET /risk_states/1/edit
  def edit
    @risk_state = RiskState.find(params[:id])
  end

  # POST /risk_states
  # POST /risk_states.xml
  def create
    @risk_state = RiskState.new(params[:risk_state])

    respond_to do |format|
      if @risk_state.save
        format.html { redirect_to(@risk_state, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @risk_state, :status => :created, :location => @risk_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_states/1
  # PUT /risk_states/1.xml
  def update
    @risk_state = RiskState.find(params[:id])

    respond_to do |format|
      if @risk_state.update_attributes(params[:risk_state])
        format.html { redirect_to(@risk_state, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_states/1
  # DELETE /risk_states/1.xml
  def destroy
    prudent_destroy(RiskState.find(params[:id]))
  end
end
