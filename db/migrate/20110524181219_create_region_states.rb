class CreateRegionStates < ActiveRecord::Migration
  def self.up
    create_table :region_states do |t|
      t.string :name
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :region_states
  end
end
