class ChangeLiningToQuotation < ActiveRecord::Migration
  def self.up
    change_column :quotations, :lining, :boolean
  end

  def self.down
    change_column :quotations, :lining, :boolean
  end
end
