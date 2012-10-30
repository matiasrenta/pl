class Expense < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :user
  belongs_to :user_recorder, :class_name => "User", :foreign_key => "user_recorder_id"
  belongs_to :project


 composed_of :amount,
             :class_name   => "Money",
             :mapping      => [%w( amount_cents cents ), %w( currency currency_as_string )],
             :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
             :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }



  validates_presence_of :amount, :amount_cents, :user, :user_recorder, :project, :description
  validates_numericality_of :amount, :greater_than => 0


end
#:constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },

