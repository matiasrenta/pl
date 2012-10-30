class RiskSourcesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /risk_sources
  # GET /risk_sources.xml
  def index
    @risk_sources = do_index(RiskSource, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @risk_sources }
    end
  end

  # GET /risk_sources/1
  # GET /risk_sources/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @risk_source }
    end
  end

  # GET /risk_sources/new
  # GET /risk_sources/new.xml
  def new
    @risk_source.state = State.active

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @risk_source }
    end
  end

  # GET /risk_sources/1/edit
  def edit
  end

  # POST /risk_sources
  # POST /risk_sources.xml
  def create

    respond_to do |format|
      if @risk_source.save
        format.html { redirect_to(risk_sources_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @risk_source, :status => :created, :location => @risk_source }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @risk_source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /risk_sources/1
  # PUT /risk_sources/1.xml
  def update

    respond_to do |format|
      if @risk_source.update_attributes(params[:risk_source])
        format.html { redirect_to(risk_sources_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @risk_source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_sources/1
  # DELETE /risk_sources/1.xml
  def destroy
    prudent_destroy(RiskSource.find(params[:id]))
  end
end
