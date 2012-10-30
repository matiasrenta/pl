class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    @user = user
    send(@user.role.i18n_name)
  end


  def superuser
    can :manage, :all
  end

  def admin
    can :manage, :all
    cannot_for_everyone
  end

  def ceo
    can :see_prices_and_cost,           User #pongo User porque debo poner algo
    can :manage,                        Holiday
    can :create_company_calendar,       Holiday, :project_id => nil
    can :update_company_calendar,       Holiday, :project_id => nil
    can [:fetch, :read],                CompanyDashboard
    can [:fetch, :read],                ProjectDashboard
    can :manage,                        Project
    can :manage,                        ProjectsUsersJoin
    can :manage,                        Task

    leader2
  end

  def leader2
    can :create, Project

    projects_authorized_as_leader_ids = Project.where("leader_id = ?", @user.id).collect { |p| p.id }
    can :manage,                        Project,  :id => projects_authorized_as_leader_ids

    leader
  end

  def leader
    can :see_conf_menu, User
    can :see_cata_menu, User

    can :see_users_availability, User
    can :see_tasks_report, User

    can [:fetch, :read, :create, :update], LifeCycle
    can [:fetch, :read, :create, :update], RiskStrategy
    can [:fetch, :read, :create, :update], RiskSource

    can [:fetch, :read, :create, :update], ExpenseType
    can [:fetch, :read, :create, :update], Area
    can [:fetch, :read, :create, :update], Company
    can [:fetch, :read, :create, :update], Country
    can [:fetch, :read, :create, :update], RegionState
    can [:fetch, :read, :create, :update], City

    projects_authorized_as_leader_ids = Project.where("leader_id = ?", @user.id).collect { |p| p.id }

    can [:fetch, :read],                Project,  :id => projects_authorized_as_leader_ids

    can :manage,                        Task,     :project_id => projects_authorized_as_leader_ids
    can :manage,                        ProjectsUsersJoin, :project_id => projects_authorized_as_leader_ids

    can :manage,                        Holiday, :project_id => projects_authorized_as_leader_ids
    can :create_project_calendar,       Holiday, :project_id => projects_authorized_as_leader_ids
    can :update_project_calendar,       Holiday, :project_id => projects_authorized_as_leader_ids

    can :manage,                        Problem, :project_id => projects_authorized_as_leader_ids
    can :manage,                        Risk,     :project_id => projects_authorized_as_leader_ids

    can :manage, Accion, :project_id => projects_authorized_as_leader_ids
    can :manage, Expense, :project_id => projects_authorized_as_leader_ids

    can [:fetch, :read], ProjectDashboard, :project_id => projects_authorized_as_leader_ids

    can :manage, Document, :project_id => projects_authorized_as_leader_ids

    can :create, Implementation, :project_id => projects_authorized_as_leader_ids

    team_member2
  end

  def team_member2
    projects_authorized_ids = @user.active_in_projects.collect { |p| p.id }
    can :manage, Expense, {:user_recorder_id => @user.id, :user_id => @user.id, :project_id => projects_authorized_ids}

    team_member
  end

  def team_member
    can :see_repo_menu, User

    can [:fetch, :read, :create], NewsItem
    can [:update, :destroy]     , NewsItem, :user_id => @user.id

    projects_authorized_ids = @user.active_in_projects.collect { |p| p.id }

    #can [:fetch, :read],              Project,              {:projects_users_joins => {:user_id => @user.id, :state_id => State.active.id} }
    can [:fetch, :read],                Project, :id => projects_authorized_ids
    can [:fetch, :read, :progress],     Task, {:project_id => projects_authorized_ids, :user_id => @user.id}
    can [:manage],                      TaskProgress #,         :task => {:project_id => projects_authorized_ids} #NO se puede hacer esto porque al momento de crear un TaskProgress este no tiene nada asignado, ni ID, habia una forma, creo que autorizando la instancia, en donde se hace el new con los valores que cargados que el ability obliga

    can [:fetch, :read],                Risk
    can [:update],                      Risk, :responsible_user_id => @user.id
    can [:manage],                      Risk, :user_id => @user.id

    can [:fetch, :read],                Problem
    can [:update],                      Problem, :responsible_user_id => @user.id
    can [:manage],                      Problem, :user_id => @user.id

#    can [:read],                        Accion
#    can [:update],                      Accion, :responsible_user_id => @user.id
#    can [:update, :destroy],            Accion, :user_id => @user.id
#    user_risks_ids = Risk.where("user_id = ? OR responsible_user_id = ?", @user.id, @user.id).collect { |r| r.id }
#    user_problems_ids = Problem.where("user_id = ? OR responsible_user_id = ?", @user.id, @user.id).collect { |p| p.id }
#    can [:update, :destroy],            Accion, {:action_source_type_id => ActionSourceType.problem.id, :problem_id => user_problems_ids}
#    can [:update, :destroy],            Accion, {:action_source_type_id => ActionSourceType.risk.id, :risk_id => user_risks_ids}

    can :read,                          Holiday
    can [:fetch, :read],                Lesson
    can [:update, :destroy],            Lesson, :user_id => @user.id

    customer
  end

  def customer
    can :see_port_menu, User
    can :see_proj_menu, User
    can [:fetch, :read],                Project,            :id => @user.view_project_ids
    can :fetch,                         Task,               :project_id => @user.view_project_ids
    can [:fetch, :read],                ProjectDashboard,   :project_id => @user.view_project_ids

    can [:read, :update],               User,               :id => @user.id

    guest
  end

  def guest
    #no se para que puede servir este role
    #cannot :see_news_block, State #todo: cambiar state por news cuando este este modelo

    cannot_for_everyone
  end

  #este metodo es para restringir cosas a nivel negocio, no importa el perfil. Ejemplo: si un Problem esta en estado cerrado NO SE PUEDE EDITAR (sea quien sea el usuario)
  def cannot_for_everyone
    cannot :update,                     Project, :project_state_id => [ProjectState.closed.id, ProjectState.canceled.id]
    cannot :update,                     Problem, :problem_state_id => ProblemState.closed.id
    cannot :update,                     Accion,  :action_state_id  => ActionState.closed.id
    cannot :update,                     Risk,    :risk_state_id    => RiskState.closed.id
    cannot :update,                     Task,    :task_state_id    => [TaskState.closed.id, TaskState.canceled.id]
    cannot [:read, :destroy],           Implementation
    cannot :update, Implementation do |implementation|
      last_implementation = Implementation.where("project_id = ?", implementation.project_id).first #es first porque el model tiene un default_scope order desc
      implementation != last_implementation #si no es el ultimo avance no se puede editar
    end

    #todo: cannot manage para todas las entidades que son CONSTANT
  end
end
