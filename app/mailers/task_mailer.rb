class TaskMailer < ActionMailer::Base
  default :from => NOREPLY_FRIENDLY

  def task_created(task)
    @task = task
    mail(:to => task.user.email, :subject => t("mails.subjects.task_created", :task_name => task.name))
  end

  def task_updated(task)
    @task = task
    mail(:to => task.user.email, :subject => t("mails.subjects.task_updated", :task_name => task.name))
  end
end
