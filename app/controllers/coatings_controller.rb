class CoatingsController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /coatings
  # GET /coatings.xml
  def index
    @coatings = do_index(Coating, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coatings }
    end
  end

  # GET /coatings/1
  # GET /coatings/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coating }
    end
  end

  # GET /coatings/new
  # GET /coatings/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coating }
    end
  end

  # GET /coatings/1/edit
  def edit
  end

  # POST /coatings
  # POST /coatings.xml
  def create

    respond_to do |format|
      if @coating.save
        format.html { redirect_to(@coating, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @coating, :status => :created, :location => @coating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /coatings/1
  # PUT /coatings/1.xml
  def update

    respond_to do |format|
      if @coating.update_attributes(params[:coating])
        format.html { redirect_to(@coating, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /coatings/1
  # DELETE /coatings/1.xml
  def destroy
    prudent_destroy(Coating.find(params[:id]))
  end
end
