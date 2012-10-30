class CreateProblemPriorities < ActiveRecord::Migration
  def self.up
    create_table :problem_priorities do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :problem_priorities
  end
end
