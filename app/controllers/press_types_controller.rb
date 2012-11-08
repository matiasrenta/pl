class PressTypesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /press_types
  # GET /press_types.xml
  def index
    @press_types = do_index(PressType, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @press_types }
    end
  end

  # GET /press_types/1
  # GET /press_types/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @press_type }
    end
  end

  # GET /press_types/new
  # GET /press_types/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @press_type }
    end
  end

  # GET /press_types/1/edit
  def edit
  end

  # POST /press_types
  # POST /press_types.xml
  def create

    respond_to do |format|
      if @press_type.save
        format.html { redirect_to(@press_type, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @press_type, :status => :created, :location => @press_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @press_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /press_types/1
  # PUT /press_types/1.xml
  def update

    respond_to do |format|
      if @press_type.update_attributes(params[:press_type])
        format.html { redirect_to(@press_type, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @press_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /press_types/1
  # DELETE /press_types/1.xml
  def destroy
    prudent_destroy(PressType.find(params[:id]))
  end
end
