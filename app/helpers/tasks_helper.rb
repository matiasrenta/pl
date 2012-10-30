module TasksHelper
  def get_proper_tasks
    Task.unscoped.includes("life_cycle_phase").select("id, name").where("tasks.project_id = ? AND task_state_id IN (?)", actual_project.id, [TaskState.assigned, TaskState.in_progress, TaskState.delayed]).order("life_cycle_phases.position DESC, planned_end_date DESC")
  end

  def disable_task_state?
    action_name == "new" || action_name == "create" || @task.closed? || @task.canceled? || !current_user.leader?(actual_project)
  end

  def put_class_for_availability(value, count)
    clase = ""
    if !value
      clase = "class='gray'" if @days_off_numbers.include?(count)
    else
      value = value.to_i
      clase = "class='yellow'" if value == 8
      clase = "class='red'" if value > 8
      clase = "class='green'" if value < 8
    end

    return clase
  end

  def put_lights_icons(coefficient)
    if coefficient <= 5
      return "accept-icon.png"
    elsif coefficient > 5 && coefficient <= 15
      return "warning-icon.png"
    else
      return "danger-icon.png"
    end
  end
end
