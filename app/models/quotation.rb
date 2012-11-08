class Quotation < ActiveRecord::Base
  belongs_to :customer
  belongs_to :press_type
  belongs_to :product
end
