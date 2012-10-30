class LifeCycle < ActiveRecord::Base
  default_scope order("name")

  has_many :projects
  has_many :life_cycle_phases, :order => "position", :dependent => :destroy

  belongs_to :state

  validates_presence_of :name, :state, :life_cycle_phases
  validate :uniq_position_for_phases

  accepts_nested_attributes_for :life_cycle_phases, :reject_if => lambda { |a| a[:position].blank? && a[:name].blank? && a[:description].blank?}, :allow_destroy => true
  attr_accessible :name, :description, :state_id
  attr_accessible :life_cycle_phases_attributes

  #lamentablemente debo hacer esta validacion muanualmente, porque la del model de phase no funciona para la creacion, ya que se cargan todas juntas
  def uniq_position_for_phases
    if self.life_cycle_phases
      self.life_cycle_phases.each do |phase|
        position = phase.position
        if position
          count = 0
          self.life_cycle_phases.each do |phase2|
            count += 1 if position == phase2.position
          end
          if count > 1
            errors.add(:base, I18n.t("screens.errors.same_order_on_phases"))
            return false
          end
        end
      end
    end
    return true
  end
end
