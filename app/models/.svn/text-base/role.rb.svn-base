class Role < ActiveRecord::Base
  #default_scope where("i18n_name <> ?", "superuser").order("position")
  default_scope order("position")

  has_many :users

  def self.guest
    find_by_i18n_name("guest")
  end

  def self.customer
    find_by_i18n_name("customer")
  end

  def self.team_member
    find_by_i18n_name("team_member")
  end

  def self.team_member2
    find_by_i18n_name("team_member2")
  end

  def self.leader
    find_by_i18n_name("leader")
  end

  def self.leader2
    find_by_i18n_name("leader2")
  end

  def self.ceo
    find_by_i18n_name("ceo")
  end

  def self.admin
    find_by_i18n_name("admin")
  end

#  def self.superuser
#    unscoped.find_by_i18n_name("superuser")
#  end


  def name
    I18n.t 'activerecord.i18n_name.Role.' + self.i18n_name
  end


  def guest?
    i18n_name == "guest"
  end

  def customer?
    i18n_name == "customer"
  end

  def team_member?
    i18n_name == "team_member"
  end

  def team_member2?
    i18n_name == "team_member2"
  end

  def leader?
    i18n_name == "leader"
  end

  def leader2?
    i18n_name == "leader2"
  end

  def ceo?
    i18n_name == "ceo"
  end

  def admin?
    i18n_name == "admin"
  end

  def superuser?
    false #por el momento he quitado el superuser porque me jode en el deployment
    #i18n_name == "superuser"
  end

  def admin_or_more?
    admin? || superuser?
  end

  def leader_or_more?
    leader? || leader2? || admin_or_more?
  end

end