class ImplementationsController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /implementations
  # GET /implementations.xml
  def index
    @implementations = Implementation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @implementations }
    end
  end

  # GET /implementations/1
  # GET /implementations/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @implementation }
    end
  end

  # GET /implementations/new
  # GET /implementations/new.xml
  def new

    @implementation.project_id = actual_project.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @implementation }
    end
  end

  # GET /implementations/1/edit
  def edit
  end

  # POST /implementations
  # POST /implementations.xml
  def create

    respond_to do |format|
      if @implementation.save
        format.html { redirect_to(@implementation.project, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @implementation, :status => :created, :location => @implementation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @implementation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /implementations/1
  # PUT /implementations/1.xml
  def update

    respond_to do |format|
      if @implementation.update_attributes(params[:implementation])
        format.html { redirect_to(@implementation.project, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @implementation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /implementations/1
  # DELETE /implementations/1.xml
  def destroy
    prudent_destroy(@implementation)
  end
end
