class Document < ActiveRecord::Base
  #attr_accessible :file, :project_id
  belongs_to :project
  mount_uploader :file, DocumentUploader

  validates_presence_of :project_id, :file
end
