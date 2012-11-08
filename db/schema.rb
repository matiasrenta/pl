# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121108181435) do

  create_table "accions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "commitment_date"
    t.integer  "user_id"
    t.integer  "responsible_user_id"
    t.integer  "action_source_type_id"
    t.integer  "action_state_id"
    t.integer  "action_priority_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id"
    t.integer  "risk_id"
  end

  create_table "action_priorities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "action_source_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "action_states", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "action_trackings", :force => true do |t|
    t.integer  "accion_id"
    t.integer  "user_id"
    t.date     "tracking_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ajaxtests", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "fecha"
    t.integer  "precio_cents"
    t.integer  "life_cycle_id"
    t.integer  "life_cycle_phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "region_state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
  end

  create_table "coatings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "phone_1"
    t.string   "phone_2"
    t.string   "postal_code"
    t.integer  "company_type_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "fax"
    t.integer  "state_id"
  end

  create_table "company_dashboards", :force => true do |t|
    t.text     "indicators"
    t.text     "costs"
    t.text     "accions_per_state"
    t.text     "open_accions_per_source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "projection"
    t.date     "at_date"
    t.text     "expenses"
    t.integer  "capacity"
    t.integer  "occupancy"
  end

  create_table "company_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers_projects_joins", :id => false, :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "day_hours", :force => true do |t|
    t.integer "hours"
  end

  create_table "days_off", :force => true do |t|
    t.integer  "wday"
    t.boolean  "company"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "off"
  end

  create_table "documents", :force => true do |t|
    t.string   "file"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense_types", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", :force => true do |t|
    t.integer  "expense_type_id"
    t.integer  "user_id"
    t.integer  "user_recorder_id"
    t.integer  "project_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.integer  "amount_cents"
    t.string   "receipt_code"
  end

  create_table "finishes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "holidays", :force => true do |t|
    t.date     "day"
    t.text     "description"
    t.boolean  "company"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "implementations", :force => true do |t|
    t.integer  "planned_progress"
    t.integer  "real_progress"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.date     "evaluation_date"
  end

  create_table "lessons", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "life_cycle_phase_id"
    t.integer  "project_id"
  end

  create_table "life_cycle_phases", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.integer  "life_cycle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "life_cycles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "machines", :force => true do |t|
    t.string   "name"
    t.date     "fecha"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organs", :id => false, :force => true do |t|
    t.string  "name",    :limit => 250
    t.integer "part_id"
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.integer  "machine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "press_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_priorities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "problem_severities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "problem_states", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "problems", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "problem_severity_id"
    t.integer  "problem_priority_id"
    t.integer  "problem_state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "responsible_user_id"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "project_dashboard_guest_user_joins", :id => false, :force => true do |t|
    t.integer  "project_dashboard_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_dashboard_present_user_joins", :id => false, :force => true do |t|
    t.integer  "project_dashboard_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_dashboards", :force => true do |t|
    t.integer  "project_id"
    t.text     "description"
    t.text     "phases_values"
    t.text     "project_values"
    t.text     "deviation_values"
    t.text     "risks"
    t.text     "accions"
    t.text     "problems"
    t.text     "present_users"
    t.text     "present_guest_users"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "ev_values"
    t.date     "at_date"
    t.integer  "user_id"
    t.boolean  "status_report"
    t.text     "expenses_values"
  end

  create_table "project_states", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "real_start_date"
    t.integer  "risk_fund_cents",              :default => 0, :null => false
    t.integer  "expense_fund_cents",           :default => 0, :null => false
    t.string   "currency"
    t.integer  "risk_strategy_id"
    t.integer  "life_cycle_id"
    t.integer  "project_state_id"
    t.integer  "area_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sale_price_cents"
    t.date     "real_end_date"
    t.integer  "leader_id"
    t.integer  "company_id"
    t.integer  "hours_day"
    t.integer  "planned_resources_cost_cents"
  end

  create_table "projects_phases_joins", :force => true do |t|
    t.integer  "planned_hours_phase"
    t.integer  "project_id"
    t.integer  "life_cycle_phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "planned_start_date"
    t.date     "planned_end_date"
  end

  create_table "projects_users_joins", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "hour_cost_in_project_cents"
    t.string   "currency"
    t.text     "responsibility"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "leader"
    t.integer  "state_id"
  end

  create_table "quotation_features", :force => true do |t|
    t.integer  "pages"
    t.integer  "inks"
    t.integer  "final_measure_width"
    t.integer  "final_measure_height"
    t.boolean  "front"
    t.boolean  "back"
    t.integer  "paper_id"
    t.integer  "coating_id"
    t.integer  "finish_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotations", :force => true do |t|
    t.string   "name"
    t.text     "observations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.integer  "press_type_id"
    t.integer  "product_id"
    t.integer  "pages"
    t.boolean  "lining"
    t.integer  "volume_1"
    t.integer  "volume_2"
    t.integer  "volume_3"
    t.integer  "volume_4"
    t.integer  "volume_5"
    t.integer  "quotation_volume_1"
    t.integer  "quotation_volume_2"
    t.integer  "quotation_volume_3"
    t.integer  "quotation_volume_4"
    t.integer  "quotation_volume_5"
  end

  create_table "region_states", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
  end

  create_table "risk_expositions", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
    t.string   "color"
  end

  create_table "risk_impacts", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "risk_probabilities", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "risk_sources", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_states", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "risk_strategies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "use_umbral"
    t.boolean  "use_real_cost"
    t.integer  "user_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_strategy_risk_source_joins", :id => false, :force => true do |t|
    t.integer  "risk_strategy_id"
    t.integer  "risk_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "detection_date"
    t.text     "umbral"
    t.string   "mitigation"
    t.string   "contingency"
    t.integer  "real_cost_cents"
    t.string   "currency"
    t.integer  "project_id"
    t.integer  "risk_source_id"
    t.integer  "risk_probability_id"
    t.integer  "risk_impact_id"
    t.integer  "risk_state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "risk_exposition_id"
    t.integer  "user_id"
    t.integer  "responsible_user_id"
    t.integer  "life_cycle_phase_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "i18n_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "states", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "task_progresses", :force => true do |t|
    t.text     "description"
    t.integer  "effort"
    t.integer  "progress"
    t.date     "working_day"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_states", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "task_types", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "i18n_name"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "planned_start_date"
    t.date     "real_start_date"
    t.date     "planned_end_date"
    t.date     "real_end_date"
    t.integer  "planned_duration"
    t.integer  "real_duration"
    t.integer  "planned_hours"
    t.integer  "real_hours"
    t.integer  "planned_progress"
    t.integer  "real_progress"
    t.integer  "planned_cost_cents"
    t.integer  "real_cost_cents"
    t.string   "currency"
    t.integer  "life_cycle_id"
    t.integer  "life_cycle_phase_id"
    t.integer  "task_state_id"
    t.integer  "project_id"
    t.integer  "task_type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  create_table "tools", :force => true do |t|
    t.string   "name"
    t.integer  "part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
    t.string   "name"
    t.string   "last_name"
    t.string   "mother_last_name"
    t.string   "work_phone"
    t.string   "cell_phone"
    t.integer  "company_id"
    t.integer  "city_id"
    t.integer  "last_project_viewed_id"
    t.integer  "role_id"
    t.text     "html_menu_items"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
