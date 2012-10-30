class LifeCyclePhasesController < ApplicationController

    load_and_authorize_resource :except => :index

  # GET /life_cycle_phases
  # GET /life_cycle_phases.xml
  def index
    @life_cycle_phases = do_index(LifeCyclePhase, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @life_cycle_phases }
    end
  end

  # GET /life_cycle_phases/1
  # GET /life_cycle_phases/1.xml
  def show
    if params[:life_cycle_id]
      @return_to_life_cycle = params[:life_cycle_id]
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @life_cycle_phase }
    end
  end

  # GET /life_cycle_phases/new
  # GET /life_cycle_phases/new.xml
  def new
    if params[:life_cycle_id]
      @life_cycle_phase.life_cycle_id = params[:life_cycle_id] #si viene del index de life_cycle se crea con el id del life_cycle
      @return_to_life_cycle = params[:life_cycle_id]

      aux = LifeCyclePhase.where("life_cycle_id = ?", params[:life_cycle_id]).maximum("position")
      @life_cycle_phase.position = (aux ? aux : 0) + 1
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @life_cycle_phase }
    end
  end

  # GET /life_cycle_phases/1/edit
  def edit
    if params[:life_cycle_id]
      @life_cycle_phase.life_cycle_id = params[:life_cycle_id] #si viene del index de life_cycle se crea con el id del life_cycle
      @return_to_life_cycle = 1
    end
  end

  # POST /life_cycle_phases
  # POST /life_cycle_phases.xml
  def create
    respond_to do |format|
      if @life_cycle_phase.save
        format.html { redirect_to(life_cycles_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @life_cycle_phase, :status => :created, :location => @life_cycle_phase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @life_cycle_phase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /life_cycle_phases/1
  # PUT /life_cycle_phases/1.xml
  def update
    respond_to do |format|
      if @life_cycle_phase.update_attributes(params[:life_cycle_phase])
        format.html { redirect_to(life_cycles_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @life_cycle_phase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /life_cycle_phases/1
  # DELETE /life_cycle_phases/1.xml
  def destroy
    prudent_destroy(@life_cycle_phase)
  end
end
