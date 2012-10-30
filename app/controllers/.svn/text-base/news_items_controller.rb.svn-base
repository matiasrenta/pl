class NewsItemsController < ApplicationController
  load_and_authorize_resource :except => [:index]
  skip_authorization_check    :only   => [:index]


  # GET /news_items
  # GET /news_items.xml
  def index
    @news_items = do_index(NewsItem, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news_items }
    end
  end

  # GET /news_items/1
  # GET /news_items/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news_item }
    end
  end

  # GET /news_items/new
  # GET /news_items/new.xml
  def new
    @news_item.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news_item }
    end
  end

  # GET /news_items/1/edit
  def edit
  end

  # POST /news_items
  # POST /news_items.xml
  def create

    respond_to do |format|
      if @news_item.save
        format.html { redirect_to(news_items_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @news_item, :status => :created, :location => @news_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news_items/1
  # PUT /news_items/1.xml
  def update

    respond_to do |format|
      if @news_item.update_attributes(params[:news_item])
        format.html { redirect_to(news_items_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news_items/1
  # DELETE /news_items/1.xml
  def destroy
    prudent_destroy(@news_item)
  end
end
