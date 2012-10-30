class Area < ActiveRecord::Base
  default_scope order("name")

  has_many :projects

  belongs_to :state

  validates_presence_of :name, :state

end
