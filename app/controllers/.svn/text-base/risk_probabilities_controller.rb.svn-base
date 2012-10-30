class RiskProbabilitiesController < ApplicationController
  # GET /risk_probabilities
  # GET /risk_probabilities.xml
  def index
    @risk_probabilities = do_index(RiskProbability, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risk_probabilities }
    end
  end

  # GET /risk_probabilities/1
  # GET /risk_probabilities/1.xml
  def show
    @risk_probability = RiskProbability.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk_probability }
    end
  end

  # GET /risk_probabilities/new
  # GET /risk_probabilities/new.xml
  def new
    @risk_probability = RiskProbability.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_probability }
    end
  end

  # GET /risk_probabilities/1/edit
  def edit
    @risk_probability = RiskProbability.find(params[:id])
  end

  # POST /risk_probabilities
  # POST /risk_probabilities.xml
  def create
    @risk_probability = RiskProbability.new(params[:risk_probability])

    respond_to do |format|
      if @risk_probability.save
        format.html { redirect_to(@risk_probability, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @risk_probability, :status => :created, :location => @risk_probability }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_probability.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_probabilities/1
  # PUT /risk_probabilities/1.xml
  def update
    @risk_probability = RiskProbability.find(params[:id])

    respond_to do |format|
      if @risk_probability.update_attributes(params[:risk_probability])
        format.html { redirect_to(@risk_probability, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_probability.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_probabilities/1
  # DELETE /risk_probabilities/1.xml
  def destroy
    prudent_destroy(RiskProbability.find(params[:id]))
  end
end
