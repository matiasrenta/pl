class City < ActiveRecord::Base
  default_scope order("name asc")

  has_many :projects
  has_many :users
  has_many :companies

  belongs_to :region_state
  belongs_to :state

  validates_presence_of :name, :region_state, :state

end
