class ProblemPrioritiesController < ApplicationController
  # GET /problem_priorities
  # GET /problem_priorities.xml
  def index
    @problem_priorities = do_index(ProblemPriority, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @problem_priorities }
    end
  end

  # GET /problem_priorities/1
  # GET /problem_priorities/1.xml
  def show
    @problem_priority = ProblemPriority.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem_priority }
    end
  end

  # GET /problem_priorities/new
  # GET /problem_priorities/new.xml
  def new
    @problem_priority = ProblemPriority.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @problem_priority }
    end
  end

  # GET /problem_priorities/1/edit
  def edit
    @problem_priority = ProblemPriority.find(params[:id])
  end

  # POST /problem_priorities
  # POST /problem_priorities.xml
  def create
    @problem_priority = ProblemPriority.new(params[:problem_priority])

    respond_to do |format|
      if @problem_priority.save
        format.html { redirect_to(@problem_priority, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @problem_priority, :status => :created, :location => @problem_priority }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @problem_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /problem_priorities/1
  # PUT /problem_priorities/1.xml
  def update
    @problem_priority = ProblemPriority.find(params[:id])

    respond_to do |format|
      if @problem_priority.update_attributes(params[:problem_priority])
        format.html { redirect_to(@problem_priority, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @problem_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_priorities/1
  # DELETE /problem_priorities/1.xml
  def destroy
    prudent_destroy(ProblemPriority.find(params[:id]))
  end
end
