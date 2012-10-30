class ProblemSeveritiesController < ApplicationController
  # GET /problem_severities
  # GET /problem_severities.xml
  def index
    @problem_severities = do_index(ProblemSeverity, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @problem_severities }
    end
  end

  # GET /problem_severities/1
  # GET /problem_severities/1.xml
  def show
    @problem_severity = ProblemSeverity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem_severity }
    end
  end

  # GET /problem_severities/new
  # GET /problem_severities/new.xml
  def new
    @problem_severity = ProblemSeverity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @problem_severity }
    end
  end

  # GET /problem_severities/1/edit
  def edit
    @problem_severity = ProblemSeverity.find(params[:id])
  end

  # POST /problem_severities
  # POST /problem_severities.xml
  def create
    @problem_severity = ProblemSeverity.new(params[:problem_severity])

    respond_to do |format|
      if @problem_severity.save
        format.html { redirect_to(@problem_severity, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @problem_severity, :status => :created, :location => @problem_severity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @problem_severity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /problem_severities/1
  # PUT /problem_severities/1.xml
  def update
    @problem_severity = ProblemSeverity.find(params[:id])

    respond_to do |format|
      if @problem_severity.update_attributes(params[:problem_severity])
        format.html { redirect_to(@problem_severity, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @problem_severity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_severities/1
  # DELETE /problem_severities/1.xml
  def destroy
    prudent_destroy(ProblemSeverity.find(params[:id]))
  end
end
