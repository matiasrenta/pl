class ActionPriority < ActiveRecord::Base
  has_many :accions

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.ActionPriority.' + self.i18n_name
  end
end
