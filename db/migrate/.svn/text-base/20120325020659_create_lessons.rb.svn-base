class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.text :description
      t.integer :projects_phases_joins_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end
