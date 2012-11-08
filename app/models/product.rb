class Product < ActiveRecord::Base
  has_many :quotations

  validates_presence_of :name
end
