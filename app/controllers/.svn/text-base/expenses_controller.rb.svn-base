class ExpensesController < ApplicationController
  load_and_authorize_resource :except => :index
  skip_authorization_check    :only   => :index
  skip_authorize_resource :only => :new

  # GET /expenses
  # GET /expenses.xml
  def index
    @expenses = do_index(Expense, params, true)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    #@expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    #@expense = Expense.new
    @expense.project = actual_project
    @expense.currency = @expense.project.currency
    @expense.user_recorder = current_user
    authorize! :new, @expense

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    #@expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    #@expense = Expense.new(params[:expense])


    respond_to do |format|
      if @expense.save
        format.html { redirect_to(expenses_path, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    #@expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to(expenses_path, :notice => t("screens.notice.successfully_updated")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    prudent_destroy(Expense.find(params[:id]))
  end
end
