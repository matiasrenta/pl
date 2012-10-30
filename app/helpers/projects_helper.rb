module ProjectsHelper

  def action_is_ajax_display_phases_form?
    action_name == "ajax_display_phases_form"
  end

  def get_proper_state_for_project
    if @project.created?
      [ProjectState.created]
    elsif @project.in_progress?
      if @project.can_be_closed?
        [ProjectState.in_progress, ProjectState.closed]
      else
        [ProjectState.in_progress, ProjectState.suspended, ProjectState.canceled]
      end
    elsif @project.suspended?
      if @project.has_any_progress? #si hay avances de tareas
        [ProjectState.in_progress, ProjectState.suspended, ProjectState.canceled]
      else
        [ProjectState.created, ProjectState.suspended, ProjectState.canceled]
      end
    elsif @project.canceled?
      [ProjectState.canceled]
    end
  end

end

