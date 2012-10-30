class Country < ActiveRecord::Base
  default_scope order("name")

  belongs_to :state

  has_many :region_states

  validates_presence_of :name, :state

end
