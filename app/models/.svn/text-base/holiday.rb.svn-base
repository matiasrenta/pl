class Holiday < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :day
  validates_presence_of :project_id, :unless => "company == true"
  validates_uniqueness_of :day, :scope => :project_id #funciona para el calendario corporativo ya que en ese caso el project_id es null

  def milis_from_1970
    self.day.to_time.to_i * 1000
  end

  def self.working_day?(project_id = nil, day = Date.today)
    return false if DayOff.is_day_off?(project_id, day)
    return false if self.where("project_id = ?", project_id).map(&:day).include?(day) if project_id
    return false if self.where("company = ?", true).map(&:day).include?(day) if !project_id
    return true
  end

  def self.company_holidays
    self.where("company = ?", true).order("day")
  end

  def self.how_many_working_days(from_date = Date.today, to_date = Date.today, porject_id = nil)
    q_days = 0
    while from_date <= to_date
      q_days += 1 if Holiday.working_day?(porject_id, from_date)
      from_date += 1.day
    end
    return q_days
  end

  def self.how_many_working_days_in_month(date = Date.today, porject_id = nil)
    how_many_working_days(date.beginning_of_month.to_date, date.end_of_month.to_date, porject_id)
  end

end
