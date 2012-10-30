class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :news_items
  end
end
