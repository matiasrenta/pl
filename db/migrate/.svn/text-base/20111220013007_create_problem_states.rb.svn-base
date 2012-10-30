class CreateProblemStates < ActiveRecord::Migration
  def self.up
    create_table :problem_states do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :problem_states
  end
end
