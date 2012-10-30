class ExpenseTypesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index

  # GET /expense_types
  # GET /expense_types.xml
  def index
    @expense_types = do_index(ExpenseType, params)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expense_types }
    end
  end

  # GET /expense_types/1
  # GET /expense_types/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense_type }
    end
  end

  # GET /expense_types/new
  # GET /expense_types/new.xml
  def new
    @expense_type.state = State.active

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense_type }
    end
  end

  # GET /expense_types/1/edit
  def edit
  end

  # POST /expense_types
  # POST /expense_types.xml
  def create

    respond_to do |format|
      if @expense_type.save
        format.html { redirect_to(expense_types_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @expense_type, :status => :created, :location => @expense_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expense_types/1
  # PUT /expense_types/1.xml
  def update

    respond_to do |format|
      if @expense_type.update_attributes(params[:expense_type])
        format.html { redirect_to(expense_types_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_types/1
  # DELETE /expense_types/1.xml
  def destroy
    prudent_destroy(ExpenseType.find(params[:id]))
  end
end
