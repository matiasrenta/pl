module ProjectsUsersJoinsHelper
  def show_cost_hour
    unless params[:projects_users_join_user_id].blank? || session[:actual_project].blank?
      return ProjectsUsersJoin.resource_cost_hour(params[:projects_users_join_user_id], session[:actual_project])
    end
    return nil
  end
end
