class Company < ActiveRecord::Base
  default_scope order("name")

  belongs_to :company_type
  belongs_to :state
  belongs_to :city

  has_many :users
  has_many :projects


  validates_presence_of :name, :company_type_id, :city_id, :address, :phone_1, :state_id

  scope :customer_companies, where("company_type_id = ?", CompanyType.customer)

  before_update :unsure_no_resources_still_working #si se pone la company a estado "inactiva" se debe poner sus recursos inactivos, simpre y cuando no esten trabajando en un projecto

  def unsure_no_resources_still_working
    #todo: ver si cambio el estado comparando con el registro en la base de datos (cambio a cancelado o cerrado)
    #todo: si ha cambiado entonces hacer una query pura y dura, lo de abajo no funciona y es confuso, a la mierda, a la vieja usansa

=begin
    users.projects.each do |project|
      if project.project_state.name != 'Cerrado'# || 'Cancelado'
        errors.add_to_base "La empresa no puede eliminarse por tener recursos trabajando en proyectos en ejecucion"
        return false
      end
    end

    users.each do |hr|
      hr.state_id = 2
      hr.user.state_id = 2
      hr.save
      hr.user.save
    end
=end

    return true
  end

end
