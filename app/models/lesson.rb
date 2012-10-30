class Lesson < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :life_cycle_phase

  validates_presence_of :project, :user, :life_cycle_phase, :description
end
