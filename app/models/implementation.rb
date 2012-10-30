class Implementation < ActiveRecord::Base
  default_scope order("evaluation_date DESC")

  belongs_to :project

  validates_presence_of :planned_progress, :real_progress, :evaluation_date, :project_id
  validates_numericality_of [:planned_progress, :real_progress], :less_than_or_equal_to => 100, :greater_than_or_equal_to => 0

  validate :no_future_evaluation_date, :if => "evaluation_date"
  validate :check_last_one , :if => "evaluation_date"

  def no_future_evaluation_date
    if self.evaluation_date.future?
      errors.add(:evaluation_date, I18n.t("errors.messages.cant_be_in_the_future"))
      return false
    end
    return true
  end

  def check_last_one
    last_implementation = Implementation.where("project_id = ?", self.project_id).first #es el first porque tiene un default_scope order("evaluation_date DESC")
    if last_implementation && last_implementation != self
      if self.evaluation_date <= last_implementation.evaluation_date
        errors.add(:evaluation_date, I18n.t("screens.errors.exists_progress_implementation_after"))
        return false
      elsif self.planned_progress < last_implementation.planned_progress
        errors.add(:planned_progress, I18n.t("screens.errors.bigger_than_last_one"))
        return false
      elsif self.real_progress < last_implementation.real_progress
        errors.add(:real_progress, I18n.t("screens.errors.bigger_than_last_one"))
        return false
      end
    end
    return true
  end
end
