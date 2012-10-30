class ActionState < ActiveRecord::Base
  default_scope order("id ASC")
  has_many :accions

  validates_presence_of :i18n_name

  def name
    I18n.t 'activerecord.i18n_name.ActionState.' + self.i18n_name
  end

  def self.open
    find_by_i18n_name("open")
  end

  def self.closed
    find_by_i18n_name("closed")
  end
end
