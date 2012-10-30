class RegionStatesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /region_states
  # GET /region_states.xml
  def index
    @region_states = do_index(RegionState, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @region_states }
    end
  end

  # GET /region_states/1
  # GET /region_states/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @region_state }
    end
  end

  # GET /region_states/new
  # GET /region_states/new.xml
  def new

    @region_state.state = State.active
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @region_state }
    end
  end

  # GET /region_states/1/edit
  def edit
  end

  # POST /region_states
  # POST /region_states.xml
  def create

    respond_to do |format|
      if @region_state.save
        format.html { redirect_to(region_states_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @region_state, :status => :created, :location => @region_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @region_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /region_states/1
  # PUT /region_states/1.xml
  def update

    respond_to do |format|
      if @region_state.update_attributes(params[:region_state])
        format.html { redirect_to(region_states_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @region_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /region_states/1
  # DELETE /region_states/1.xml
  def destroy
    prudent_destroy(RegionState.find(params[:id]))
  end
end
