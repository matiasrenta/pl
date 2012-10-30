class ActionPrioritiesController < ApplicationController
  # GET /action_priorities
  # GET /action_priorities.xml

  def index
    @action_priorities = do_index(ActionPriority, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @action_priorities }
    end
  end

  # GET /action_priorities/1
  # GET /action_priorities/1.xml
  def show
    @action_priority = ActionPriority.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @action_priority }
    end
  end

  # GET /action_priorities/new
  # GET /action_priorities/new.xml
  def new
    @action_priority = ActionPriority.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @action_priority }
    end
  end

  # GET /action_priorities/1/edit
  def edit
    @action_priority = ActionPriority.find(params[:id])
  end

  # POST /action_priorities
  # POST /action_priorities.xml
  def create
    @action_priority = ActionPriority.new(params[:action_priority])

    respond_to do |format|
      if @action_priority.save
        format.html { redirect_to(@action_priority, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @action_priority, :status => :created, :location => @action_priority }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /action_priorities/1
  # PUT /action_priorities/1.xml
  def update
    @action_priority = ActionPriority.find(params[:id])

    respond_to do |format|
      if @action_priority.update_attributes(params[:action_priority])
        format.html { redirect_to(@action_priority, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /action_priorities/1
  # DELETE /action_priorities/1.xml
  def destroy
    prudent_destroy(ActionPriority.find(params[:id]))
  end
end
