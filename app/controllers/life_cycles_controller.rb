class LifeCyclesController < ApplicationController

  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index


  # GET /life_cycles
  # GET /life_cycles.xml
  def index
    @life_cycles = do_index(LifeCycle, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @life_cycles }
    end
  end

  # GET /life_cycles/1
  # GET /life_cycles/1.xml
  def show
    search_algoritm
    @search = @life_cycle.life_cycle_phases.search(params[:search])
    @life_cycle_phases = @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @life_cycle }
    end
  end

  # GET /life_cycles/new
  # GET /life_cycles/new.xml
  def new
    @life_cycle.state = State.active
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @life_cycle }
    end
  end

  # GET /life_cycles/1/edit
  def edit
  end

  # POST /life_cycles
  # POST /life_cycles.xml
  def create
    respond_to do |format|
      if @life_cycle.save
        format.html { redirect_to(life_cycles_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @life_cycle, :status => :created, :location => @life_cycle }
      else
        #este lio de abajo es para que ordene las fases por el numero de orden (el problema es que aun no estan en la base, entonces hay que ordenar el array, y para colmo puede estar en nil el orden)
        if @life_cycle.life_cycle_phases
          @life_cycle.life_cycle_phases.each do |phase|
            phase.position = 0 if phase.position.blank?
          end
          @life_cycle.life_cycle_phases.sort! { |a, b| a[:position] <=> b[:position] }
          @life_cycle.life_cycle_phases.each do |phase|
            phase.position = nil if phase.position == 0
          end
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @life_cycle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /life_cycles/1
  # PUT /life_cycles/1.xml
  def update

    respond_to do |format|
      if @life_cycle.update_attributes(params[:life_cycle])
        format.html { redirect_to(life_cycles_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @life_cycle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /life_cycles/1
  # DELETE /life_cycles/1.xml
  def destroy
    prudent_destroy(@life_cycle)
  end
end
