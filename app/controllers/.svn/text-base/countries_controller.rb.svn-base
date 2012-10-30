class CountriesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /countries
  # GET /countries.xml
  def index
    @countries = do_index(Country, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/new
  # GET /countries/new.xml
  def new

    @country.state = State.active
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  # POST /countries.xml
  def create

    respond_to do |format|
      if @country.save
        format.html { redirect_to(countries_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to(countries_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.xml
  def destroy
    prudent_destroy(Country.find(params[:id]))
  end
end
