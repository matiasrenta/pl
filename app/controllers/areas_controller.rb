class AreasController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /areas
  # GET /areas.xml
  def index
    @areas = do_index(Area, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.xml
  def new
    @area.state = State.active

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @area }
    end
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.xml
  def create

    respond_to do |format|
      if @area.save
        format.html { redirect_to(areas_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @area, :status => :created, :location => @area }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.xml
  def update

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to(areas_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.xml
  def destroy
    prudent_destroy(Area.find(params[:id]))
  end
end
