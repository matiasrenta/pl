class CreateActionTrackings < ActiveRecord::Migration
  def self.up
    create_table :action_trackings do |t|
      t.integer :accion_id
      t.integer :user_id
      t.date :tracking_date
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :action_trackings
  end
end