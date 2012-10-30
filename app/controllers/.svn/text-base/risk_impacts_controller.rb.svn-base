class RiskImpactsController < ApplicationController
  # GET /risk_impacts
  # GET /risk_impacts.xml
  def index
    @risk_impacts = do_index(RiskImpact, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risk_impacts }
    end
  end

  # GET /risk_impacts/1
  # GET /risk_impacts/1.xml
  def show
    @risk_impact = RiskImpact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk_impact }
    end
  end

  # GET /risk_impacts/new
  # GET /risk_impacts/new.xml
  def new
    @risk_impact = RiskImpact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_impact }
    end
  end

  # GET /risk_impacts/1/edit
  def edit
    @risk_impact = RiskImpact.find(params[:id])
  end

  # POST /risk_impacts
  # POST /risk_impacts.xml
  def create
    @risk_impact = RiskImpact.new(params[:risk_impact])

    respond_to do |format|
      if @risk_impact.save
        format.html { redirect_to(@risk_impact, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @risk_impact, :status => :created, :location => @risk_impact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_impact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_impacts/1
  # PUT /risk_impacts/1.xml
  def update
    @risk_impact = RiskImpact.find(params[:id])

    respond_to do |format|
      if @risk_impact.update_attributes(params[:risk_impact])
        format.html { redirect_to(@risk_impact, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_impact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_impacts/1
  # DELETE /risk_impacts/1.xml
  def destroy
    prudent_destroy(RiskImpact.find(params[:id]))
  end
end
