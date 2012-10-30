class ActionSourceTypesController < ApplicationController
  # GET /action_source_types
  # GET /action_source_types.xml
  def index
    @action_source_types = do_index(ActionSourceType, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @action_source_types }
    end
  end

  # GET /action_source_types/1
  # GET /action_source_types/1.xml
  def show
    @action_source_type = ActionSourceType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @action_source_type }
    end
  end

  # GET /action_source_types/new
  # GET /action_source_types/new.xml
  def new
    @action_source_type = ActionSourceType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @action_source_type }
    end
  end

  # GET /action_source_types/1/edit
  def edit
    @action_source_type = ActionSourceType.find(params[:id])
  end

  # POST /action_source_types
  # POST /action_source_types.xml
  def create
    @action_source_type = ActionSourceType.new(params[:action_source_type])

    respond_to do |format|
      if @action_source_type.save
        format.html { redirect_to(@action_source_type, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @action_source_type, :status => :created, :location => @action_source_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action_source_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /action_source_types/1
  # PUT /action_source_types/1.xml
  def update
    @action_source_type = ActionSourceType.find(params[:id])

    respond_to do |format|
      if @action_source_type.update_attributes(params[:action_source_type])
        format.html { redirect_to(@action_source_type, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action_source_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /action_source_types/1
  # DELETE /action_source_types/1.xml
  def destroy
    prudent_destroy(ActionSourceType.find(params[:id]))
  end
end
