class ProjectsPhasesJoinsController < ApplicationController
  # GET /projects_phases_joins
  # GET /projects_phases_joins.xml
  def index
    @projects_phases_joins = do_index(ProjectsPhasesJoin, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects_phases_joins }
    end
  end

  # GET /projects_phases_joins/1
  # GET /projects_phases_joins/1.xml
  def show
    @projects_phases_join = ProjectsPhasesJoin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @projects_phases_join }
    end
  end

  # GET /projects_phases_joins/new
  # GET /projects_phases_joins/new.xml
  def new
    @projects_phases_join = ProjectsPhasesJoin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @projects_phases_join }
    end
  end

  # GET /projects_phases_joins/1/edit
  def edit
    @projects_phases_join = ProjectsPhasesJoin.find(params[:id])
  end

  # POST /projects_phases_joins
  # POST /projects_phases_joins.xml
  def create
    @projects_phases_join = ProjectsPhasesJoin.new(params[:projects_phases_join])

    respond_to do |format|
      if @projects_phases_join.save
        format.html { redirect_to(@projects_phases_join, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @projects_phases_join, :status => :created, :location => @projects_phases_join }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @projects_phases_join.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects_phases_joins/1
  # PUT /projects_phases_joins/1.xml
  def update
    @projects_phases_join = ProjectsPhasesJoin.find(params[:id])

    respond_to do |format|
      if @projects_phases_join.update_attributes(params[:projects_phases_join])
        format.html { redirect_to(@projects_phases_join.project, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @projects_phases_join.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects_phases_joins/1
  # DELETE /projects_phases_joins/1.xml
  def destroy
    prudent_destroy(ProjectsPhasesJoin.find(params[:id]))

    respond_to do |format|
      format.html { redirect_to(projects_phases_joins_url) }
      format.xml  { head :ok }
    end
  end
end
