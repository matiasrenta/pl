class ExpenseType < ActiveRecord::Base
  default_scope order("title")

  belongs_to :state

  has_many :expenses

  validates_presence_of :title, :state

end
