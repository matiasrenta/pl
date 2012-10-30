class RiskExpositionsController < ApplicationController
  # GET /risk_expositions
  # GET /risk_expositions.xml
  def index
    @risk_expositions = do_index(RiskExposition, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risk_expositions }
    end
  end

  # GET /risk_expositions/1
  # GET /risk_expositions/1.xml
  def show
    @risk_exposition = RiskExposition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk_exposition }
    end
  end

  # GET /risk_expositions/new
  # GET /risk_expositions/new.xml
  def new
    @risk_exposition = RiskExposition.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_exposition }
    end
  end

  # GET /risk_expositions/1/edit
  def edit
    @risk_exposition = RiskExposition.find(params[:id])
  end

  # POST /risk_expositions
  # POST /risk_expositions.xml
  def create
    @risk_exposition = RiskExposition.new(params[:risk_exposition])

    respond_to do |format|
      if @risk_exposition.save
        format.html { redirect_to(@risk_exposition, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @risk_exposition, :status => :created, :location => @risk_exposition }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_exposition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_expositions/1
  # PUT /risk_expositions/1.xml
  def update
    @risk_exposition = RiskExposition.find(params[:id])

    respond_to do |format|
      if @risk_exposition.update_attributes(params[:risk_exposition])
        format.html { redirect_to(@risk_exposition, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_exposition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_expositions/1
  # DELETE /risk_expositions/1.xml
  def destroy
    prudent_destroy(RiskExposition.find(params[:id]))
  end
end
