class ApplicationController < ActionController::Base
  check_authorization :unless => :devise_controller?
  skip_authorization_check :only => [:index, :access_denied]

  before_filter :authenticate_user!
  before_filter :set_content_title
  before_filter :set_projects
  before_filter :set_actual_project
  #before_filter :prepare_for_mobile
  #before_filter :set_user_language

  protect_from_forgery

  #load_and_authorize_resource :except => :index

  def index
    case current_user.role.i18n_name
      when 'customer'                     :
        if actual_project && actual_project.project_dashboards.count > 0
          redirect_to(actual_project.project_dashboards.order("id DESC").first)
        else
          flash[:alert] = t("screens.alerts.no_view_projects")
        end

      when 'team_member':
        if actual_project
          redirect_to("/tasks/progress")
        end

      when 'team_member2':
        if actual_project
          redirect_to("/tasks/progress")
        end

      when 'leader':
        start_page_for_leaders

      when 'leader2':
        start_page_for_leaders
      when 'ceo':
        company_dashboard = CompanyDashboard.first
        redirect_to(company_dashboard) if company_dashboard

      when 'admin':
        company_dashboard = CompanyDashboard.first
        redirect_to(company_dashboard) if company_dashboard
    end
  end

  def start_page_for_leaders
    if actual_project
      if actual_project.project_dashboards.count > 0
        redirect_to(actual_project.project_dashboards.first)
      else
        redirect_to(project_path(actual_project))
      end
    end
  end

  def access_denied
    set_content_title(t("screens.labels.access_denied"))
  end

  protected ############################################ PROTECTED #################################################

  def set_projects
    @projects_for_select = Project.accessible_by(current_ability, :fetch).order("name") if user_signed_in?
  end

  def set_actual_project
    if params[:project_changed]
      session[:actual_project] = params[:project_changed]
      current_user.update_attribute(:last_project_viewed_id, session[:actual_project])
      #cookies[:actual_project] = { :value => session[:actual_project].id, :expires => 30.days.from_now }
    else
      unless session[:actual_project]
        if user_signed_in?
          #session[:actual_project] = @projects_for_select.first.try(:id) #null si no estuviera asignado a ningun proyecto
          if current_user.last_project_viewed_id && ((can? :fetch, current_user.last_project_viewed)) # || current_user.view_projects.include(current_user.last_project_viewed))
            session[:actual_project] = current_user.last_project_viewed_id
          elsif current_user.role.customer? && current_user.view_projects.count > 0
            session[:actual_project] = current_user.view_projects.first.id
            current_user.update_attribute(:last_project_viewed_id, session[:actual_project])
          elsif current_user.role.team_member? || current_user.role.team_member2? || current_user.role.leader? || current_user.role.leader2?
            if @projects_for_select && @projects_for_select.count > 0
              session[:actual_project] = @projects_for_select.first.id
              current_user.update_attribute(:last_project_viewed_id, session[:actual_project])
            end
          end
        end
      end
    end
  end

  def set_content_title(title = "", separator = " - ")
    content_title = ""

    if title.blank?
      if action_name == "index"
        title = [t("activerecord.models."+controller_name.camelize)]
      else
        title = [t("activerecord.models."+controller_name.camelize.singularize), t("activerecord.actions."+action_name)]
      end
    end

    i=0
    title.each do |title_part|
      case i
        when 0: content_title = ("<h1>"+title_part+"</h1>").html_safe
        when 1: content_title += ("<h2>" + separator + title_part + "</h2>").html_safe
        else    content_title += ("<h3>" + separator + title_part + "</h3>").html_safe
      end
      i += 1
    end
    session["content_title"] = content_title
  end

  def set_user_language
    I18n.locale = 'es' #current_user.language if user_signed_in?
  end

  def delocalize_dates(fields)
    fields.each do |field|
      date_s = params[:search][field]
      unless date_s.blank?
        d = date_s.split('/')[0]
        m = date_s.split('/')[1]
        y = date_s.split('/')[2]
        params[:search][field] = m + '/' + d + '/' + y
      end
    end
  end

  def integerize_money(fields)
    fields.each do |field|
      money_s = params[:search][field]
      unless money_s.blank?
        money_s = money_s.split('.').to_s.split(',').to_s
        params[:search][field] = money_s
      end
    end
  end

  def per_page(quantity)
    if !quantity.blank?
      cookies[:per_page] = {:value => quantity, :expires => 30.days.from_now}
    elsif cookies[:per_page].blank?
      cookies[:per_page] = {:value => "20", :expires => 30.days.from_now} #default 20 per page
    end
    params[:per_page] = cookies[:per_page]
    cookies[:per_page]
  end

  def search_algoritm
    params[:search] = nil if params[:search_clear]
    if params[:search]
      params[:search].each do |param|
        unless param[1].blank?
          @filter_active = true;
          break
        end
      end
    end
  end

  def do_index(model, params, filter_by_actual_project = false, default_order = false, paginate = true)
    search_algoritm

    if filter_by_actual_project
      if default_order
        @search = model.where("project_id = ?", session[:actual_project]).accessible_by(current_ability, :fetch).search(params[:search])
      elsif params[:search] && params[:search][:meta_sort]
        @search = model.unscoped.where("project_id = ?", session[:actual_project]).accessible_by(current_ability, :fetch).search(params[:search])
      else
        @search = model.unscoped.where("project_id = ?", session[:actual_project]).order("updated_at DESC, created_at DESC").accessible_by(current_ability, :fetch).search(params[:search])
      end
    else
      if default_order
        @search = model.accessible_by(current_ability, :fetch).search(params[:search])
      elsif params[:search] && params[:search][:meta_sort]
        @search = model.unscoped.accessible_by(current_ability, :fetch).search(params[:search])
      else
        @search = model.unscoped.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :fetch).search(params[:search])
      end
    end

    if paginate
      @search.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
    else
      @search.all
    end
  end

  def prudent_destroy(model, assoc_exceptions = [])
    if model.destroyable?(assoc_exceptions)
      model.destroy
    else
      flash[:warning] = model.errors.full_messages if model.errors.any?
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml { head :ok }
    end
  end

  def actual_project
    return nil unless session[:actual_project]
    Project.find(session[:actual_project])
  end


  private ############################################ PRIVATE #################################################



  def mobile_device?
    #false
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end



  def after_sign_out_path_for(user)
    new_user_session_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/application/access_denied", :alert => t("screens.labels.access_denied")
  end




end
