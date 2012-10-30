class ProjectDashboard < ActiveRecord::Base
  default_scope order("at_date DESC")

  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :present_users, :class_name => "User", :join_table => "project_dashboard_present_user_joins", :association_foreign_key => 'user_id'
  has_and_belongs_to_many :guest_users, :class_name => "User", :join_table => "project_dashboard_guest_user_joins", :association_foreign_key => 'user_id'

  serialize :phases_values
  serialize :project_values
  serialize :deviation_values
  serialize :risks
  serialize :accions
  serialize :problems
  serialize :present_users
  serialize :present_guest_users
  serialize :ev_values
  serialize :expenses_values

  def generate(date = Date.today)
    self.phases_values    = generate_phases(date)
    self.project_values   = generate_project(date)
    self.deviation_values = generate_deviation
    self.ev_values        = generate_ev(date)
    self.expenses_values  = generate_expenses(date)
    associated_models
  end

  def regenerate_associated_models
    associated_models
    save
  end

  private

  def generate_phases(date)
    phase_progress_hours_cost = Hash.new
    #self.project.life_cycle.life_cycle_phases.each do |life_cycle_phase|
    self.project.projects_phases_joins.each do |pfj|
      data = Hash.new

      data["planned_phase_progress"] = (pfj.planned_progress(date) * 100).round
      data["real_phase_progress"] = (pfj.real_progress(date) * 100).round

      data["planned_phase_effort"] = pfj.planned_effort(date).round
      data["real_phase_effort"] = pfj.real_effort(date).round

      data["planned_phase_cost"] = pfj.planned_cost(date).to_money(self.project.currency)
      data["real_phase_cost"] = pfj.real_cost(date).to_money(self.project.currency)

      phase_progress_hours_cost[pfj.life_cycle_phase.id] = data
    end
    return phase_progress_hours_cost
  end

  def generate_project(date)
    project_values = Hash.new
    project_values[:planned_project_progress] = self.project.planned_progress(date)
    project_values[:real_project_progress]    = self.project.real_progress(date)
    project_values[:planned_project_effort]   = self.project.planned_effort(date)
    project_values[:real_project_effort]      = self.project.real_effort(date)
    project_values[:planned_project_cost]     = self.project.planned_cost(date).to_money(@project.currency)
    project_values[:real_project_cost]        = self.project.real_cost(date).to_money(@project.currency)

    return project_values
  end

  def generate_deviation
    deviation_values = Hash.new

    #puts "self.project_values[:real_project_effort] = " + self.project_values[:real_project_effort].to_s
    #puts "self.project_values[:planned_project_effort] = " + self.project_values[:planned_project_effort].to_s
    #puts "self.project_values[:real_project_effort] - self.project_values[:planned_project_effort] = " + (self.project_values[:real_project_effort] - self.project_values[:planned_project_effort]).to_s

    last_implementation = self.project.implementations.first
    if last_implementation
      deviation_values[:implementation_deviation] = deviation_range( Float(last_implementation.real_progress - last_implementation.planned_progress) / last_implementation.real_progress )
    end

    deviation_values[:progress_deviation] = deviation_range( (Float(self.project_values[:real_project_progress]) - Float(self.project_values[:planned_project_progress])) / self.project_values[:planned_project_progress] * 100)
    deviation_values[:effort_deviation]   = deviation_range( (Float(self.project_values[:real_project_effort]) - Float(self.project_values[:planned_project_effort])) / self.project_values[:planned_project_effort] * 100 )
    deviation_values[:cost_deviation]     = deviation_range( (self.project_values[:real_project_cost] - self.project_values[:planned_project_cost]) / self.project_values[:planned_project_cost] * 100 )
    return deviation_values
  end

  def deviation_range(deviation)
    #puts "@@@@@@@@@@@@@ deviation: " + deviation.to_s
    deviation = deviation.abs
    deviation_range = Hash.new
    deviation_range[:num] = deviation
    case
      when deviation <= 5
        deviation_range[:value] = "Bajo"
        deviation_range[:color] = "green"
        deviation_range[:image] = "accept-icon.png"
      when 5 < deviation && deviation <= 20
        deviation_range[:value] = "Medio"
        deviation_range[:color] = "yellow"
        deviation_range[:image] = "warning-icon.png"
      when 20 < deviation
        deviation_range[:value] = "Alto"
        deviation_range[:color] = "red"
        deviation_range[:image] = "danger-icon.png"
    end

    return deviation_range
  end

  def generate_ev(date = Date.today)
    #hacer un array con todos los viernes del proyecto todo: seria bueno por anio
    fridays = Array.new
    next_friday = self.project.real_start_date.sunday - 1.days
    last_date = (self.project.real_end_date.blank? || date < self.project.real_end_date) ? date : self.project.real_end_date


    while next_friday <= last_date
      fridays << next_friday
      next_friday += 7.days
    end

    return nil unless fridays.count > 0

    acev = Array.new
    acpv = Array.new
    acac = Array.new
    ahev = Array.new
    ahpv = Array.new
    ahac = Array.new

    fridays.each do |friday|
      #CÁLCULO CON COSTOS
      acev << self.project.cost_ev(friday)
      acpv << self.project.cost_pv(friday)
      acac << self.project.cost_ac(friday)
      #CÁLCULO CON HORAS
      ahev << self.project.hour_ev(friday)
      ahpv << self.project.hour_pv(friday)
      ahac << self.project.hour_ac(friday)
    end

    #si se superan este numero de semanas los dos graficos de EV aparecen uno arriba del otro y bien anchos
    ev_charts_big = true if acev.size > 30

    #Desempeño del Costo
    c_cpi = (acev.last / acac.last).round(2)
    h_cpi = (ahev.last / ahac.last).round(2)

    #Desempeño del Calendario
    c_spi = (acev.last / acpv.last).round(2)
    h_spi = (ahev.last / ahpv.last).round(2)

    #calculo del BAC (la suma de horas y la suma de costo, ambas planeadas de todas las fases del proyecto. Es la tabla project_phase_joins)
    c_bac = 0.00
    h_bac = 0.00

    c_bac += Float(self.project.planned_resources_cost)
    self.project.projects_phases_joins.each do |ppj|
      h_bac += Float(ppj.planned_hours_phase)
    end

    c_eac = (acac.last + c_bac - acev.last).to_money(self.project.currency)
    projection_money  = acac.last - acev.last #si da negativo pongo la palabra 'menos' y el valor absoluto
    more_or_less_text = projection_money >= 0 ? "más" : "menos"
    c_projection_text = I18n.t("screens.labels.projection_text_money", {:amount => projection_money.abs.to_money, :currency => self.project.currency, :more_less => more_or_less_text})

    h_eac = (ahac.last + h_bac - ahev.last).round
    projection_hours = ahac.last - ahev.last #si da negativo pongo la palabra 'menos' y el valor absoluto
    more_or_less_text = projection_hours >= 0 ? "más" : "menos"
    h_projection_text = I18n.t("screens.labels.projection_text_hours", {:amount => projection_hours.abs.round, :more_less => more_or_less_text})

    ev_values = {
        :acev => acev,
        :acpv => acpv,
        :acac => acac,
        :ahev => ahev,
        :ahpv => ahpv,
        :ahac => ahac,
        :ev_charts_big => ev_charts_big,
        :c_cpi => c_cpi,
        :h_cpi => h_cpi,
        :c_spi => c_spi,
        :h_spi => h_spi,
        :projection_money => projection_money,
        :c_projection_text => c_projection_text,
        :h_projection_text => h_projection_text,
        :c_bac => c_bac,
        :h_bac => h_bac,
        :c_eac => c_eac,
        :h_eac => h_eac
    }

    return ev_values
  end

  def generate_expenses(date)
    expenses_sum = self.project.expenses.where("created_at <= ?", date).sum(:amount_cents) / 100
    expenses = {:expense_fund => self.project.expense_fund, :expenses_sum => expenses_sum.to_money(self.project.currency)}
    return expenses
  end

  def associated_models
    self.risks = Risk.unscoped.where("project_id = ? and risk_state_id = ?", self.project_id, RiskState.find_by_i18n_name("open")).order("updated_at DESC, created_at DESC")
    self.accions = Accion.unscoped.where("project_id = ? and action_state_id in (?)", self.project_id, ActionState.find_by_i18n_name("open")).order("updated_at DESC, created_at DESC")
    self.problems = Problem.unscoped.where("project_id = ? and problem_state_id = ?", self.project_id, ProblemState.find_by_i18n_name("open")).order("updated_at DESC, created_at DESC")
  end

end
