class ProjectsUsersJoinsController < ApplicationController

  load_and_authorize_resource :except => [:index, :new, :update_user_select]

  # GET /projects_users_joins
  # GET /projects_users_joins.xml
  def index
    @projects_users_joins = do_index(ProjectsUsersJoin, params, true)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @projects_users_joins }
    end
  end

  # GET /projects_users_joins/1
  # GET /projects_users_joins/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @projects_users_join }
    end
  end

  # GET /projects_users_joins/new
  # GET /projects_users_joins/new.xml
  def new
    @projects_users_join = ProjectsUsersJoin.new
    @projects_users_join.project_id = session[:actual_project]
    @projects_users_join.currency = @projects_users_join.project.currency
    @projects_users_join.state = State.active
    @projects_users_join.leader = false
    authorize! :new, @projects_users_join

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @projects_users_join }
    end
  end

  # GET /projects_users_joins/1/edit
  def edit
    #sql = "SELECT * FROM users WHERE not exists (select * from projects_users_joins where user_id = users.id AND project_id = ?) ORDER BY users.name, users.last_name"
    #@users_not_assigned = User.find_by_sql([sql, @projects_users_join.project_id])
    #@users_not_assigned = User.not_assigned_to_project(@projects_users_join.project_id)
    #@users_not_assigned = User.not_assigned_to_project(@projects_users_join.project_id, @projects_users_join.user_id)
  end

  # POST /projects_users_joins
  # POST /projects_users_joins.xml
  def create
    puj = ProjectsUsersJoin.find_by_project_id_and_user_id(@projects_users_join.project_id, @projects_users_join.user_id)
    if puj
      puj.attributes = params[:projects_users_join]
      @projects_users_join = puj
    end

    respond_to do |format|
      if @projects_users_join.save
        format.html { redirect_to(@projects_users_join.project, :notice => t("screens.notice.successfully_created")) }
        format.xml { render :xml => @projects_users_join, :status => :created, :location => @projects_users_join }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @projects_users_join.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects_users_joins/1
  # PUT /projects_users_joins/1.xml
  def update
    #@projects_users_join = ProjectsUsersJoin.find(params[:id])

    respond_to do |format|
      if @projects_users_join.update_attributes(params[:projects_users_join])
        set_info_if_reassigned_tasks
        format.html { redirect_to(@projects_users_join.project, :notice => t("screens.notice.successfully_updated")) }
        format.xml { head :ok }
      else
        #@users_not_assigned = User.not_assigned_to_project(@projects_users_join.project_id, @projects_users_join.user_id) unless @projects_users_join.project_id.blank?
        format.html { render :action => "edit" }
        format.xml { render :xml => @projects_users_join.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects_users_joins/1
  # DELETE /projects_users_joins/1.xml
  def destroy
    @projects_users_join.destroy

    if @projects_users_join.errors.has_key?(:tasks_present)
      if @projects_users_join.active?
        warning_message = @projects_users_join.errors[:tasks_present]
        #@projects_users_join.state = State.inactive
        #@projects_users_join.save #no se por que, pero si ejecuto la linea de abajo no funciona la logica para notificar que se envia mail para reasignar tareas, no se updetea el atributo en memoria antes de ejecutar :inactivate_logic en el model
        set_info_if_reassigned_tasks
        #@projects_users_join.update_attributes(:state_id => State.inactive.id) #lamentablemente si hago esto no funciona :inactivate_logic en el model
      else
        warning_message = t("screens.errors.puj_cant_be_deleted")
      end
      redirect_to(:back, :flash => {:warning => warning_message})
    else
      respond_to do |format|
        format.html { redirect_to(:back, :alert => (@projects_users_join.errors.any? ? @projects_users_join.errors.full_messages : nil)) }
        format.xml { head :ok }
      end
    end

  end

  def set_info_if_reassigned_tasks
    if @projects_users_join.errors.has_key?(:info_reassign_tasks)
      flash[:info] = @projects_users_join.errors[:info_reassign_tasks]
    end
  end



  # Update the select box base on project selection box
  def update_user_select
    #sql = "SELECT * FROM users WHERE not exists (select * from projects_users_joins where user_id = users.id AND project_id = ?) ORDER BY users.name, users.last_name"
    #@users_not_assigned = User.find_by_sql([sql, params[:id]])
    #@users_not_assigned = User.not_assigned_to_project(params[:id])
    #@users_not_assigned = User.not_assigned_to_project(params[:id]) unless params[:id] == "0"
    #render :partial => "users_select", :locals => { :users_not_assigned => @users_not_assigned }

#    render :update do |page|
#      page.replace_html 'users_select', :partial => 'users_select', :object => @users_not_assigned
#    end

    @options_for_select = "<option value=''></option>"
    @users_not_assigned.each do |user|
      @options_for_select += "<option value='"+ user.id.to_s + "'>"+ user.full_name + "</option>"
    end
  end

end
