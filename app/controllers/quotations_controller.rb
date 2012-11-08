class QuotationsController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /quotations
  # GET /quotations.xml
  def index
    @quotations = do_index(Quotation, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quotations }
    end
  end

  # GET /quotations/1
  # GET /quotations/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quotation }
    end
  end

  # GET /quotations/new
  # GET /quotations/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quotation }
    end
  end

  # GET /quotations/1/edit
  def edit
  end

  # POST /quotations
  # POST /quotations.xml
  def create

    respond_to do |format|
      if @quotation.save
        format.html { redirect_to(@quotation, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @quotation, :status => :created, :location => @quotation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quotations/1
  # PUT /quotations/1.xml
  def update

    respond_to do |format|
      if @quotation.update_attributes(params[:quotation])
        format.html { redirect_to(@quotation, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.xml
  def destroy
    prudent_destroy(Quotation.find(params[:id]))
  end
end
