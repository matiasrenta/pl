xml.instruct!
xml.project do
  @phases.each do |phase|
    generated_phase_id = Time.now.to_i + phase.id
    xml.task do
      xml.pID generated_phase_id
      xml.pName phase.name
      xml.pStart phase.tasks
      xml.pEnd
      xml.pColor '0000ff'
      xml.pLink
      xml.pMile 0
      xml.pRes
      xml.pComp 0
      xml.pGroup 1
      xml.pParent 0
      xml.pOpen 1
      xml.pDepend
    end

    Task.unscoped.where("project_id = ? AND life_cycle_phase_id = ?", session[:actual_project], phase.id).order("planned_start_date ASC").each do |task|
      xml.task do
        xml.pID task.id
        xml.pName task.name
        xml.pStart task.planned_start_date
        xml.pEnd task.planned_end_date
        xml.pColor '0000ff'
        xml.pLink
        xml.pMile 0
        xml.pRes task.user.full_name
        xml.pComp task.real_progress_percent
        xml.pGroup 0
        xml.pParent generated_phase_id
        xml.pOpen 1
        xml.pDepend task.parent.id if task.parent
        xml.pWorkingDuration task.planned_duration
      end
    end
  end
end
