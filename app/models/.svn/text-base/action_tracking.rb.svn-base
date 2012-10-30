class ActionTracking < ActiveRecord::Base
  belongs_to :accion
  belongs_to :user

  validates_presence_of :user, :tracking_date, :description
end
