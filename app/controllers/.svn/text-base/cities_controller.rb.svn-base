class CitiesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /cities
  # GET /cities.xml
  def index
    @cities = do_index(City, params)

#    #availability_occupancy
#    start_month = 5.months.ago.beginning_of_month
#    end_month = 6.months.from_now.end_of_month
#
#    working_days_by_month = Array.new
#    resources_by_month = Array.new
#    next_month = start_month
#    12.times do
#      working_days_by_month << Holiday.how_many_working_days_in_month(next_month)
#      User.actives.resources.where()
#      next_month += 1.month
#    end
#
#    puts "########################################"
#    puts working_days_by_month.join(", ")
#    puts "########################################"
#
#    capacity_by_month = Array.new
#
#    12.times do
#
#    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @cities }
    end
  end

  # GET /cities/1
  # GET /cities/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @city }
    end
  end

  # GET /cities/new
  # GET /cities/new.xml
  def new

    @city.state = State.active
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @city }
    end
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.xml
  def create

    respond_to do |format|
      if @city.save
        format.html { redirect_to(cities_path, :notice => t("screens.notice.successfully_created")) }
        format.xml { render :xml => @city, :status => :created, :location => @city }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.xml
  def update

    respond_to do |format|
      if @city.update_attributes(params[:city])
        format.html { redirect_to(cities_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.xml
  def destroy
    prudent_destroy(@city)
  end
end
