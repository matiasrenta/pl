class DayOff < ActiveRecord::Base
  set_table_name "days_off"

  belongs_to :project

  def self.is_day_off?(project_id = nil, day = Date.today)
    self.where("project_id = ? and off = ?", project_id, true).map(&:wday).include?(day.wday) if project_id
    self.where("company = ? and off = ?", true, true).map(&:wday).include?(day.wday) if !project_id
  end

  def self.days_off_only(project_id = nil)
    #si project_id es nil, entonces deberia devolver los days_off de la company
    where("project_id = ? and off = ?", project_id, true).map(&:wday) #si project_id es nil, entonces deberia devolver los days_off de la company
  end


  def self.calendar_wday_classes(project_id = nil)
    calendar_wday_class = Array.new
    days_off = self.where("project_id = ?", project_id) if project_id
    days_off = self.where("company = ?", true) if !project_id
    days_off.each do |day_off|
      if day_off.off
        case day_off.wday
          when 0: calendar_wday_class << "td.fc-sun"
          when 1: calendar_wday_class << "td.fc-mon"
          when 2: calendar_wday_class << "td.fc-tue"
          when 3: calendar_wday_class << "td.fc-wed"
          when 4: calendar_wday_class << "td.fc-thu"
          when 5: calendar_wday_class << "td.fc-fri"
          when 6: calendar_wday_class << "td.fc-sat"
        end
      end
    end

    calendar_wday_class.join(', ')
  end

  def self.company_days_off
    self.where("company = ? and off = ?", true, true)
  end

  def self.days_off_numbers_in_month(date = Date.today, project_id = nil)
    inicio = date.beginning_of_month
    month = date.month

    where("project_id = ? and off = ?", project_id, true).map(&:wday)
    days_off = where("project_id = ? and off = ?", project_id, true).map(&:wday) if project_id
    days_off = where("company = ? and off = ?", true, true).map(&:wday) if !project_id

    days_off_numbers = Array.new
    while month == inicio.month do
      days_off_numbers << (inicio - 1.day).day if days_off.include?(inicio.wday)
      inicio += 1.day
    end

    return days_off_numbers
  end

end
