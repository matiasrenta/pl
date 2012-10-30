class ActionTrackingsController < ApplicationController
  # GET /action_trackings
  # GET /action_trackings.xml
  def index
    @action_trackings = do_index(ActionTracking, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @action_trackings }
    end
  end

  # GET /action_trackings/1
  # GET /action_trackings/1.xml
  def show
    @action_tracking = ActionTracking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @action_tracking }
    end
  end

  # GET /action_trackings/new
  # GET /action_trackings/new.xml
  def new
    @action_tracking = ActionTracking.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @action_tracking }
    end
  end

  # GET /action_trackings/1/edit
  def edit
    @action_tracking = ActionTracking.find(params[:id])
  end

  # POST /action_trackings
  # POST /action_trackings.xml
  def create
    @action_tracking = ActionTracking.new(params[:action_tracking])

    respond_to do |format|
      if @action_tracking.save
        format.html { redirect_to(@action_tracking, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @action_tracking, :status => :created, :location => @action_tracking }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action_tracking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /action_trackings/1
  # PUT /action_trackings/1.xml
  def update
    @action_tracking = ActionTracking.find(params[:id])

    respond_to do |format|
      if @action_tracking.update_attributes(params[:action_tracking])
        format.html { redirect_to(@action_tracking, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action_tracking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /action_trackings/1
  # DELETE /action_trackings/1.xml
  def destroy
    prudent_destroy(ActionTracking.find(params[:id]))
  end
end
