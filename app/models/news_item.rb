class NewsItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :title, :description, :user_id
end
