class QuotationFeaturesController < ApplicationController
  # GET /quotation_features
  # GET /quotation_features.xml
  def index
    @quotation_features = QuotationFeature.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quotation_features }
    end
  end

  # GET /quotation_features/1
  # GET /quotation_features/1.xml
  def show
    @quotation_feature = QuotationFeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quotation_feature }
    end
  end

  # GET /quotation_features/new
  # GET /quotation_features/new.xml
  def new
    @quotation_feature = QuotationFeature.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quotation_feature }
    end
  end

  # GET /quotation_features/1/edit
  def edit
    @quotation_feature = QuotationFeature.find(params[:id])
  end

  # POST /quotation_features
  # POST /quotation_features.xml
  def create
    @quotation_feature = QuotationFeature.new(params[:quotation_feature])

    respond_to do |format|
      if @quotation_feature.save
        format.html { redirect_to(@quotation_feature, :notice => 'Quotation feature was successfully created.') }
        format.xml  { render :xml => @quotation_feature, :status => :created, :location => @quotation_feature }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quotation_feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quotation_features/1
  # PUT /quotation_features/1.xml
  def update
    @quotation_feature = QuotationFeature.find(params[:id])

    respond_to do |format|
      if @quotation_feature.update_attributes(params[:quotation_feature])
        format.html { redirect_to(@quotation_feature, :notice => 'Quotation feature was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quotation_feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quotation_features/1
  # DELETE /quotation_features/1.xml
  def destroy
    @quotation_feature = QuotationFeature.find(params[:id])
    @quotation_feature.destroy

    respond_to do |format|
      format.html { redirect_to(quotation_features_url) }
      format.xml  { head :ok }
    end
  end
end
