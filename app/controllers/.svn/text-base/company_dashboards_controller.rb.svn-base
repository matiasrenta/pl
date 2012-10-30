class CompanyDashboardsController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check    :only   => [:index, :go_to_project_dash]
  #skip_authorize_resource :only => :new


  # GET /company_dashboards
  # GET /company_dashboards.xml
  def index
    #@company_dashboards = do_index(CompanyDashboard, params)
    params[:search] = nil if params[:search_clear]
    delocalize_dates([:at_date_greater_than_or_equal_to, :at_date_less_than_or_equal_to]) if params[:search]
    search_algoritm
    @search = CompanyDashboard.select("id, description, at_date").accessible_by(current_ability, :fetch).search(params[:search])
    @company_dashboards = @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
  end

  # GET /company_dashboards/1
  # GET /company_dashboards/1.xml
  def show
    #@company_dashboard = CompanyDashboard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company_dashboard }
    end
  end

  # GET /company_dashboards/new
  # GET /company_dashboards/new.xml
  def new
    @company_dashboard = CompanyDashboard.new
  end

  # GET /company_dashboards/1/edit
  def edit
    @company_dashboard = CompanyDashboard.find(params[:id])
  end

  # POST /company_dashboards
  # POST /company_dashboards.xml
  def create
    #@company_dashboard = CompanyDashboard.new(params[:company_dashboard])
    @company_dashboard.generate(@company_dashboard.at_date)

    respond_to do |format|
      if @company_dashboard.save
        format.html { redirect_to(@company_dashboard, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @company_dashboard, :status => :created, :location => @company_dashboard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company_dashboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /company_dashboards/1
  # PUT /company_dashboards/1.xml
  def update
    @company_dashboard = CompanyDashboard.find(params[:id])

    respond_to do |format|
      if @company_dashboard.update_attributes(params[:company_dashboard])
        format.html { redirect_to(@company_dashboard, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company_dashboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /company_dashboards/1
  # DELETE /company_dashboards/1.xml
  def destroy
    @company_dashboard = CompanyDashboard.find(params[:id])
    @company_dashboard.destroy

    respond_to do |format|
      format.html { redirect_to(company_dashboards_url) }
      format.xml  { head :ok }
    end
  end

  def go_to_project_dash
    redirect_to(actual_project.project_dashboards.order("at_date DESC").first)
  end

end
