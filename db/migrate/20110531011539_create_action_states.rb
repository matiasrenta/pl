class CreateActionStates < ActiveRecord::Migration
  def self.up
    create_table :action_states do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :action_states
  end
end
