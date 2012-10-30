class HolidaysController < ApplicationController
  load_and_authorize_resource :except => [:index, :save_days_off]
  skip_authorization_check    :only   => [:index, :save_days_off]

  # GET /holidays
  # GET /holidays.xml
  def index
    if params[:company]
      @holiday = Holiday.new(:project_id => nil)
      set_content_title([t("screens.labels.company_calendar")])
      @days_enable = can? :update_company_calendar, @holiday
      @dates_creation = can? :create_company_calendar, @holiday
      @holidays = Holiday.company_holidays
      @days_off = DayOff.company_days_off
      @holiday.company = true
      @days_off_for_fullcalendar = DayOff.calendar_wday_classes()
    else
      @holiday = Holiday.new(:project_id => actual_project.id)
      set_content_title([t("screens.labels.project_calendar")])
      @days_enable = can? :update_project_calendar, @holiday
      @dates_creation = can? :create_project_calendar, @holiday
      @holidays = actual_project.holidays.order("day")
      @days_off = actual_project.get_days_off
      @days_off_for_fullcalendar = DayOff.calendar_wday_classes(actual_project)
    end


    @holidays_for_fullcalendar = @holidays.map(&:milis_from_1970).join(', ')
    #@holidays_for_fullcalendar = "1335852000000, 1337148000000, 1337234400000"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @holidays }
    end
  end

  # POST /holidays
  # POST /holidays.xml
  def create
    @holiday = Holiday.new(params[:holiday])

    redirect = holidays_path
    redirect = holidays_path(:company => true) if !params[:holiday][:company].blank?

    respond_to do |format|
      if @holiday.save
        format.html { redirect_to(redirect, :notice => t("screens.notice.successfully_created")) }
        format.xml  { render :xml => @holiday, :status => :created, :location => @holiday }
      else
        format.html { redirect_to(redirect, :alert => @holiday.errors.full_messages.join(", ") ) }
        format.xml  { render :xml => @holiday.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /holidays/1
  # DELETE /holidays/1.xml
  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end


  #save/update days_off para el projecto actual o el corporativo
  def save_days_off
    if params[:company]
      days_off = DayOff.where("company = ?", true)
      redirect = holidays_path(:company => true)
      day_hours = DayHour.first
      day_hours.hours = params[:day_hours]
      day_hours.save!
    else
      days_off = DayOff.where("project_id = ?", session[:actual_project])
      redirect = holidays_path
      ap = actual_project
      ap.hours_day = params[:day_hours]
      ap.save!(:validate => false) #por las dudas le pongo que skip validations, no vaya a ser que de un error
    end
    days_off.each do |day|
      day.off = true
      case day.wday
        when 0: day.off = false unless params[:wday_domingo]
        when 1: day.off = false unless params[:wday_lunes]
        when 2: day.off = false unless params[:wday_martes]
        when 3: day.off = false unless params[:wday_miercoles]
        when 4: day.off = false unless params[:wday_jueves]
        when 5: day.off = false unless params[:wday_viernes]
        when 6: day.off = false unless params[:wday_sabado]
      end
      day.save!
    end
    redirect_to(redirect, :notice => t("screens.notice.successfully_created"))
  end

end
