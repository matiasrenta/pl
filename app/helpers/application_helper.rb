module ApplicationHelper

  #metodo recursivo para print cosas como @city.region_state.country.name  si alguno de los objetos intermedio es nil entonces devuelve "", sino devuelve el valor. sirve en los listados cuando los campos no son requeridos
  def print_attribute(object, methods, attribute = "name")
    unless methods.empty?
      if result = object.send(methods.shift)
        print_attribute(result, methods, attribute)
      else
        return ""
      end
    else
      return object.send(attribute)
    end
  end

  def avatar_url(user)
#    if user.avatar_url.present?
#      user.avatar_url
#    else
      default_url = "#{root_url}images/guest_user.gif"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
#    end
  end

  def major_currencies(hash)
    hash.inject([]) do |array, (id, attributes)|
      priority = attributes[:priority]
      if priority && priority < 10
        array ||= []
        array << [attributes[:name], attributes[:iso_code]]
      end
      array
    end
  end

  def all_currencies(hash)
    hash.inject([]) do |array, (id, attributes)|
      array ||= []
      array << [attributes[:name], attributes[:iso_code]]
      array
    end
  end

  def handle_nested_models_errors(model_instance)
    #return unless model_instance && model_instance.errors.any?

    nested_model_messages = Array.new
    model_instance.errors.each do |error|
      #obtener solo los errores de los nested models
      model_chain = error[0].to_s.split(".")
      if model_chain.size > 1
         nested_model_messages << t("activerecord.models." + model_chain[model_chain.size - 2].to_s.camelize) + ": " + t("activerecord.attributes." + model_chain[model_chain.size - 2].to_s.underscore.singularize + "." + model_chain[model_chain.size - 1].to_s) + " " + error[1].to_s
      end
    end
    nested_model_messages
  end

  def creating?
    ["new", "create"].include?(action_name)
  end

  def updating?
    ["edit", "update"].include?(action_name)
  end

  def listing?
    action_name == "index"
  end

  def showing?
    action_name == "show"
  end

  def actual_project
    return nil unless session[:actual_project]
    Project.find(session[:actual_project])
  end


  #model_or_relation: no tiene sentido enviar un model (ej: LifeCycle) porque cuando se haga .all obviamente contendra al actual
  #attribute_name es el atributo con el cual sera sort la collection
  def collection_with_actual(model_or_relation, actual = nil, attribute_name = :name)
    collection = model_or_relation     if model_or_relation.class == Array
    collection = model_or_relation.all unless model_or_relation.class == Array

    if actual.respond_to?(:each) #si envio un array de valores actuales, como en relaciones many_to_many como la del project_dashboard con users
      actual.each do |act|
        collection << act if !collection.include?(act)
      end
      collection.sort! { |a, b| a.try(attribute_name).downcase <=> b.try(attribute_name).downcase }
    elsif actual && !collection.include?(actual)
      collection << actual
      collection.sort! { |a,b| a.try(attribute_name).downcase <=> b.try(attribute_name).downcase }
    end
    return collection
  end

  def decimal_to_percentage(decimal)
    decimal * 100
  end

  def menu
    session[:menu] = nil if session[:project_in_menu] != actual_project.try(:id)
    if !session[:menu]
      ini = "htmlMenu: \""
      port = "<div class=\\\"voice {panel:'/menus/portafolio.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_341_briefcase_white.png' alt=''/>#{t('screens.menu.portfolio')}</span></div>"
      proj = ""
      if actual_project
        proj = "<div class=\\\"voice {panel:'/menus/project.html'}\\\"><span class='label'><img src='/images/glyphicons/white/aperture_24x24.png' alt=''/>#{actual_project.name.length > 15 ? actual_project.name[0..13] + '...' : actual_project.name}</span></div>"
      end
      #conf = "<div class=\\\"voice {panel:'/menus/config_projects.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_023_cogwheels.png' alt=''/>#{t('screens.menu.conf_projects')}</span></div>"
      cata = "<div class=\\\"voice {panel:'/menus/catalogs.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_351_book_open.png' alt=''/>#{t('screens.menu.catalogs')}</span> </div>"
      #repo = "<div class=\\\"voice {panel:'/menus/reports.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_029_notes_2.png' alt=''/>#{t('screens.menu.reports')}</span></div>"
      admi = "<div class=\\\"voice {panel:'/menus/administration.html'}\\\"><span class='label'><img src='/images/glyphicons/white/glyphicons_029_notes_2.png' alt=''/>#{t('screens.menu.administration')}</span></div>"
      supe = "<div class=\\\"voice {panel:'/menus/super_user.html'}\\\"><span class='label'>Superuser</span></div>"
      fin = "\","

      menu = ini + ((can? :see_port_menu, User) ? port : "") +
            ((actual_project && (can? :see_proj_menu, User)) ? proj : "") +
            #((can? :see_conf_menu, User) ? conf : "") +
            ((can? :see_cata_menu, User) ? cata : "") +
            #((can? :see_repo_menu, User) ? repo : "") +
            ((current_user.role.admin_or_more?) ? admi : "") +
            ((current_user.role.superuser?) ? supe : "") +
            fin
      session[:menu] = menu
    end
    return session[:menu]
  end

  def menuItems
    session[:menu_items] = nil if session[:project_in_menu] != actual_project.try(:id)
    if session[:menu_items]
      menuItems = current_user.html_menu_items #lo guardo en el user porque no puedo ponerlo en session, supera los 4K permitidos
    else
      go_to_company_dash = CompanyDashboard.order("at_date DESC").first
      go_to_project_dash = ProjectDashboard.where("project_id = ?", actual_project ? actual_project.id : nil).order("at_date DESC").first


      menuItems =
            "
            portItems:{
                       main: #{(can? :see_port_menu, User) ? "true" : "false"},
                       quotations: #{(can? :read, Project) ? "true" : "false"},
                        html_quotations: '<div>#{link_to(t("screens.menu.port.quotations"), projects_path, :class => 'ajax')}</div>',
                       company_dashboard: #{(can? :read, CompanyDashboard) ? "true" : "false"},
                        html_company_dashboard: '<div>#{link_to(t("screens.menu.port.dashboard"), go_to_company_dash ? go_to_company_dash : company_dashboards_path, :class => 'ajax')}</div>',
                       corporate_calendar: #{(can? :read, Holiday) ? "true" : "false"},
                        html_corporate_calendar: '<div>#{link_to(t("screens.menu.port.company_calendar"), holidays_path(:company => true), :class => 'ajax')}</div>'
                      },

            projItems:{
                       main: #{(actual_project && (can? :see_proj_menu, User)) ? "true" : "false"},
                       project_data: #{(can? :read, actual_project)},
                        html_project_data: '<div>#{link_to(t("screens.menu.proj.project_data"), actual_project, :class => 'ajax')}</div>',
                       tasks: #{(can? :read, Task) ? "true" : "false"},
                        html_tasks: '<div>#{link_to(t("screens.menu.proj.tasks"), tasks_path, :class => 'ajax')}</div>',
                       task_progress: #{(can? :progress, Task) ? "true" : "false"},
                        html_task_progress: '<div>#{link_to(t("screens.menu.proj.progress_task"), "/tasks/progress", :class => 'ajax')}</div>',
                       risks: #{(can? :read, Risk) ? "true" : "false"},
                        html_risks: '<div>#{link_to(t("screens.menu.proj.risks"), risks_path, :class => 'ajax')}</div>',
                       problems: #{(can? :read, Problem) ? "true" : "false"},
                        html_problems: '<div>#{link_to(t("screens.menu.proj.problems"), problems_path, :class => 'ajax')}</div>',
                       accions: #{(actual_project && (can? :read, Accion.new(:project_id => actual_project.id))) ? "true" : "false"},
                        html_accions: '<div>#{link_to(t("screens.menu.proj.accions"), accions_path, :class => 'ajax')}</div>',
                       expenses: #{(actual_project && (can? :read, Expense.new(:project_id => actual_project.id, :user_recorder_id => current_user.id, :user_id => current_user.id))) ? "true" : "false"},
                        html_expenses: '<div>#{link_to(t("screens.menu.proj.expenses"), expenses_path, :class => 'ajax')}</div>',
                       project_dashboards: #{(actual_project && ((can? :read, ProjectDashboard.new(:project_id => actual_project.id)) && actual_project.project_state != ProjectState.created)) ? "true" : "false"},
                        html_project_dashboards: '<div>#{link_to(t("screens.menu.proj.dashboard"), go_to_project_dash ? go_to_project_dash : project_dashboards_path, :class => 'ajax')}</div>',

                       lessons: #{(can? :read, Lesson) ? "true" : "false"},
                        html_lessons: '<div>#{link_to(t("screens.menu.proj.lessons"), lessons_path, :class => 'ajax')}</div>',
                      },

            confItems:{
                       main: #{(can? :see_conf_menu, User) ? "true" : "false"},
                       life_cycles: #{(can? :read, LifeCycle) ? "true" : "false"},
                       html_life: '<div>#{link_to(t('screens.menu.conf.life_cycles'), life_cycles_path, :class => 'ajax')}</div>',
                       risk_strategies: #{(can? :read, RiskStrategy) ? "true" : "false"},
                       html_strategies: '<div>#{link_to(t("screens.menu.conf.risk_strategies"), risk_strategies_path, :class => 'ajax')}</div>',
                       risk_sources: #{(can? :read, RiskSource) ? "true" : "false"},
                       html_sources: '<div>#{link_to(t("screens.menu.conf.risk_sources"), risk_sources_path, :class => 'ajax')}</div>'
                      },
            cataItems:{
                       main: #{(can? :see_cata_menu, User) ? "true" : "false"},
                       customers: #{(can? :read, Customer) ? "true" : "false"},
                        html_customers: '<div>#{link_to(t("screens.menu.cata.customers"), customers_path, :class => 'ajax')}</div>',
                       products: #{(can? :read, Product) ? "true" : "false"},
                        html_products: '<div>#{link_to(t("screens.menu.cata.products"), products_path, :class => 'ajax')}</div>',
                       coatings: #{(can? :read, Coating) ? "true" : "false"},
                        html_coatings: '<div>#{link_to(t("screens.menu.cata.coatings"), coatings_path, :class => 'ajax')}</div>',
                       finishes: #{(can? :read, Finish) ? "true" : "false"},
                        html_finishes: '<div>#{link_to(t("screens.menu.cata.finishes"), finishes_path, :class => 'ajax')}</div>',
                       regions_states: #{(can? :read, RegionState) ? "true" : "false"},
                        html_regions_states: '<div>#{link_to(t("screens.menu.cata.states"), region_states_path, :class => 'ajax')}</div>',
                       cities: #{(can? :read, City) ? "true" : "false"},
                        html_cities: '<div>#{link_to(t("screens.menu.cata.cities"), cities_path, :class => 'ajax')}</div>'
                      },
            admiItems:{
                       main: #{(current_user.role.admin_or_more?) ? "true" : "false"},
                       html_users: '<div>#{link_to(t("screens.menu.admi.users"), users_path, :class => 'ajax')}</div>',
                      },
            supeItems:#{(current_user.role.superuser?) ? "true" : "false"},"
      current_user.update_attribute(:html_menu_items, menuItems) #lo guardo en el user porque no puedo ponerlo en session, supera los 4K permitidos
      session[:project_in_menu] = actual_project.id if actual_project
    end
    return menuItems
  end

end
