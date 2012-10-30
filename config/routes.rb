Pru1::Application.routes.draw do

  resources :finishes

  resources :coatings

  resources :products

  resources :customers

  resources :implementations

  resources :news_items

  get "application/access_denied"

  resources :documents

#  post "menus/extrudertop"
#  post "menus/portafolio"
#  post "menus/project"
#  post "menus/config_projects"
#  post "menus/catalogs"
#  post "menus/reports"
#  post "menus/administration"
#  post "menus/super_user"


  resources :lessons

  resources :company_dashboards do
    match "go_to_project_dash", :on => :collection
  end

  resources :project_dashboards

  resources :things

  resources :projects_phases_joins

  resources :tools

  resources :holidays do
    match 'save_days_off', :on => :collection
  end

  resources :problems

  resources :problem_states

  resources :problem_priorities

  resources :problem_severities

  resources :ajaxtests do
    match 'fill_phases', :on => :collection
  end

  resources :cars



=begin
  get "project_status_report/index"

  get "users/index"

  get "users/show"
=end

  resources :risks do
    match 'ajax_calculate_risk_exposition', :on => :collection
  end

  resources :risk_states

  resources :risk_exposition_strategies

  resources :risk_expositions

  resources :risk_impacts

  resources :risk_probabilities

  resources :risk_sources

  resources :risk_categories

  resources :task_progresses

  resources :tasks do
    match 'progress', :on => :collection
    collection do
      get  'report'
      post 'ajax_display_planned_end_date'
    end
  end




#  resources :tasks do   #para poner mas de un miembro
#    member do
#      match 'avance_tasks'
#      match 'pindonga'
#    end
#  end


  resources :task_states

  resources :task_types

  resources :projects_users_joins do
    #match 'update_user_select', :on => :collection
    #match 'ajax_get_resource_cost', :on => :collection
    collection do
      get 'ajax_get_resource_cost'
    end
  end

  resources :accions do
    match 'ajax_display_risk_or_problem', :on => :collection
  end

  resources :expenses

  resources :expense_types

  resources :areas

  resources :project_states

  resources :risk_strategies

  resources :action_trackings

  resources :action_states

  resources :action_priorities

  resources :action_source_types

  resources :trackings

  resources :company_types

  resources :cities


  match '/projects/ajax_display_phases_form'
  resources :projects do
    collection do
      get 'gantt'
    end
  end

  resources :companies

  resources :human_resources

  resources :life_cycle_phases

  resources :life_cycles

  resources :sponsored_areas

  resources :region_states

  resources :countries

  resources :states

  devise_for :users

  resources :users do
    match 'ajax_display_view_projects', :on => :collection
    match 'resend_password_instructions', :on => :collection
  end





  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "application#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
