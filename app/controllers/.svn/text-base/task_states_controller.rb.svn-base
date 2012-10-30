class TaskStatesController < ApplicationController
  # GET /task_states
  # GET /task_states.xml
  def index
    @task_states = do_index(TaskState, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @task_states }
    end
  end

  # GET /task_states/1
  # GET /task_states/1.xml
  def show
    @task_state = TaskState.find(params[:id])

    if params[:next_version]
      @task_state = @task_state.next_version
    elsif params[:prev_version]
      @task_state = @task_state.version_at(1.hours.ago)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task_state }
    end
  end

  # GET /task_states/new
  # GET /task_states/new.xml
  def new
    @task_state = TaskState.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task_state }
    end
  end

  # GET /task_states/1/edit
  def edit
    @task_state = TaskState.find(params[:id])
  end

  # POST /task_states
  # POST /task_states.xml
  def create
    @task_state = TaskState.new(params[:task_state])

    respond_to do |format|
      if @task_state.save
        format.html { redirect_to(@task_state, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @task_state, :status => :created, :location => @task_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /task_states/1
  # PUT /task_states/1.xml
  def update
    @task_state = TaskState.find(params[:id])

    respond_to do |format|
      if @task_state.update_attributes(params[:task_state])
        format.html { redirect_to(@task_state, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /task_states/1
  # DELETE /task_states/1.xml
  def destroy
    prudent_destroy(TaskState.find(params[:id]))
  end
end
