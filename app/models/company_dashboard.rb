class CompanyDashboard < ActiveRecord::Base
  default_scope order("at_date DESC")

  serialize :indicators
  serialize :costs
  serialize :expenses
  serialize :accions_per_state
  serialize :open_accions_per_source
  serialize :projection


  def self.generate_project_and_company_dashboards_from_cron(date = Date.today)
    # primero creo todos los ProjectDashboard del dia actual, los cuales son usados para generar el CompanyDashboard del dia actual
    Project.in_progress.each do |project|
      project_dashboard = ProjectDashboard.new({:project_id => project.id, :at_date => date, :user_id => User.where("role_id = ?", Role.admin.id).first})
      project_dashboard.generate(date)
      project_dashboard.save!
    end

    # ahora genero el CompanyDashboard
    company_dashboard = CompanyDashboard.new(:at_date => date)
    company_dashboard.generate(date)
    company_dashboard.save!
  end



  def generate(date = Date.today)
    project_dashboards = ProjectDashboard.where("at_date = ?", date)
    indicators = Array.new
    costs = Array.new
    expenses = Array.new
    pie_distribution = {:total => 0, :hasta_uno => 0, :dos_a_cinco => 0, :seis_a_diez => 0, :once_a_veinte => 0, :veintiuno_a_cien => 0}

    project_dashboards.each do |pd|
      project_indicators = {
        :id             => pd.project.id,
        :name           => pd.project.name,
        :planned_start_date => pd.project.planned_start_date.to_s,
        :real_start_date    => pd.project.real_start_date.to_s,
        :planned_end_date    => pd.project.planned_end_date.to_s,
        :implementation_image => pd.deviation_values[:implementation_deviation] ? pd.deviation_values[:implementation_deviation][:image] : nil,
        :effort_image   => pd.deviation_values[:effort_deviation][:image],
        :cost_image     => pd.deviation_values[:cost_deviation][:image],
        :progress_image => pd.deviation_values[:progress_deviation][:image]
      }
      indicators << project_indicators

      project_costs = {
        :name         => pd.project.name,
        :planned_cost => pd.project_values[:planned_project_cost],
        :real_cost    => pd.project_values[:real_project_cost]
      }
      costs << project_costs

      project_expenses = {
        :name         => pd.project.name,
        :expense_fund => pd.expenses_values[:expense_fund],
        :expenses_sum => pd.expenses_values[:expenses_sum]
      }
      expenses << project_expenses

      #torta de proyeccion
      if pd.ev_values
        coefficient = Float(pd.ev_values[:projection_money]) / Float(pd.ev_values[:c_bac]) * 100
        #coefficient = 0.5
        #if coefficient >= 1
        if coefficient >= 0
          pie_distribution[:total] += 1
          #percent = ((coefficient - 1) * 100).round
          percent = coefficient
          if    0 <= percent && percent <= 1
            pie_distribution[:hasta_uno] += 1
          elsif 1 < percent && percent <= 5
            pie_distribution[:dos_a_cinco] += 1
          elsif 5 < percent && percent <= 10
            pie_distribution[:seis_a_diez] += 1
          elsif 10 < percent && percent <= 20
            pie_distribution[:once_a_veinte] += 1
          elsif 20 < percent && percent <= 100
            pie_distribution[:veintiuno_a_cien] += 1
          end
        end
      end
    end
    pie_distribution[:hasta_uno] = Float(pie_distribution[:hasta_uno]) / pie_distribution[:total] * 100                if pie_distribution[:hasta_uno] > 0
    pie_distribution[:dos_a_cinco] =      Float(pie_distribution[:dos_a_cinco]) / pie_distribution[:total] * 100            if pie_distribution[:dos_a_cinco] > 0
    pie_distribution[:seis_a_diez] =      Float(pie_distribution[:seis_a_diez]) / pie_distribution[:total] * 100            if pie_distribution[:seis_a_diez] > 0
    pie_distribution[:once_a_veinte] =    Float(pie_distribution[:once_a_veinte]) / pie_distribution[:total] * 100        if pie_distribution[:once_a_veinte] > 0
    pie_distribution[:veintiuno_a_cien] = Float(pie_distribution[:veintiuno_a_cien]) / pie_distribution[:total] * 100  if pie_distribution[:veintiuno_a_cien] > 0


    self.indicators = indicators
    self.costs      = costs
    self.expenses   = expenses
    self.projection = pie_distribution if pie_distribution[:total] > 0


    #todas las aciones de los projects que esten en in_progress
    ps_ip_id = ProjectState.in_progress.id
    accions_total       = Accion.joins(:project).where("project_state_id = ?", ps_ip_id).count
    accions_open        = Accion.opens.joins(:project).where("project_state_id = ?", ps_ip_id).count
    accions_closed      = Accion.closed.joins(:project).where("project_state_id = ?", ps_ip_id).count

    self.accions_per_state = {
        :open   => accions_total > 0 ? (Float(accions_open)   / accions_total * 100) : 0,
        :closed => accions_total > 0 ? (Float(accions_closed) / accions_total * 100) : 0
    }


    #capacity_occupancy
    if Holiday.working_day?(nil, date)
      self.capacity = DayHour.hours * User.actives.resources.where("created_at <= ?", date).count
      self.occupancy = TaskProgress.day_occupancy(date)
    end


    #cantidad de acciones por fuente
#    self.open_accions_per_source = {
#        :problem  => Accion.opens.joins(:project).where("project_state_id = ? AND action_source_type_id = ?", ps_ip_id, ActionSourceType.problem).count,
#        :report   => Accion.opens.joins(:project).where("project_state_id = ? AND action_source_type_id = ?", ps_ip_id, ActionSourceType.report).count,
#        :risk     => Accion.opens.joins(:project).where("project_state_id = ? AND action_source_type_id = ?", ps_ip_id, ActionSourceType.risk).count,
#        :decision => Accion.opens.joins(:project).where("project_state_id = ? AND action_source_type_id = ?", ps_ip_id, ActionSourceType.decision).count
#    }
  end
end
