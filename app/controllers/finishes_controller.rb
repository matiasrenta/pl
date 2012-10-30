class FinishesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /finishes
  # GET /finishes.xml
  def index
    @finishes = do_index(Finish, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @finishes }
    end
  end

  # GET /finishes/1
  # GET /finishes/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @finish }
    end
  end

  # GET /finishes/new
  # GET /finishes/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @finish }
    end
  end

  # GET /finishes/1/edit
  def edit
  end

  # POST /finishes
  # POST /finishes.xml
  def create

    respond_to do |format|
      if @finish.save
        format.html { redirect_to(@finish, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @finish, :status => :created, :location => @finish }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @finish.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /finishes/1
  # PUT /finishes/1.xml
  def update

    respond_to do |format|
      if @finish.update_attributes(params[:finish])
        format.html { redirect_to(@finish, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @finish.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /finishes/1
  # DELETE /finishes/1.xml
  def destroy
    prudent_destroy(Finish.find(params[:id]))
  end
end
