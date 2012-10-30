class CreateProblemSeverities < ActiveRecord::Migration
  def self.up
    create_table :problem_severities do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :problem_severities
  end
end
