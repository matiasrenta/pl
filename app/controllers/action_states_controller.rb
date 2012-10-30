class ActionStatesController < ApplicationController
  # GET /action_states
  # GET /action_states.xml
  def index
    @action_states = do_index(ActionState, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @action_states }
    end
  end

  # GET /action_states/1
  # GET /action_states/1.xml
  def show
    @action_state = ActionState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @action_state }
    end
  end

  # GET /action_states/new
  # GET /action_states/new.xml
  def new
    @action_state = ActionState.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @action_state }
    end
  end

  # GET /action_states/1/edit
  def edit
    @action_state = ActionState.find(params[:id])
  end

  # POST /action_states
  # POST /action_states.xml
  def create
    @action_state = ActionState.new(params[:action_state])

    respond_to do |format|
      if @action_state.save
        format.html { redirect_to(@action_state, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @action_state, :status => :created, :location => @action_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /action_states/1
  # PUT /action_states/1.xml
  def update
    @action_state = ActionState.find(params[:id])

    respond_to do |format|
      if @action_state.update_attributes(params[:action_state])
        format.html { redirect_to(@action_state, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /action_states/1
  # DELETE /action_states/1.xml
  def destroy
    prudent_destroy(ActionState.find(params[:id]))
  end
end
