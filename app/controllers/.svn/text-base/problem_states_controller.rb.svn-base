class ProblemStatesController < ApplicationController
  # GET /problem_states
  # GET /problem_states.xml
  def index
    @problem_states = do_index(ProblemState, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @problem_states }
    end
  end

  # GET /problem_states/1
  # GET /problem_states/1.xml
  def show
    @problem_state = ProblemState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @problem_state }
    end
  end

  # GET /problem_states/new
  # GET /problem_states/new.xml
  def new
    @problem_state = ProblemState.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @problem_state }
    end
  end

  # GET /problem_states/1/edit
  def edit
    @problem_state = ProblemState.find(params[:id])
  end

  # POST /problem_states
  # POST /problem_states.xml
  def create
    @problem_state = ProblemState.new(params[:problem_state])

    respond_to do |format|
      if @problem_state.save
        format.html { redirect_to(@problem_state, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @problem_state, :status => :created, :location => @problem_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @problem_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /problem_states/1
  # PUT /problem_states/1.xml
  def update
    @problem_state = ProblemState.find(params[:id])

    respond_to do |format|
      if @problem_state.update_attributes(params[:problem_state])
        format.html { redirect_to(@problem_state, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @problem_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_states/1
  # DELETE /problem_states/1.xml
  def destroy
    prudent_destroy(ProblemState.find(params[:id]))
  end
end
