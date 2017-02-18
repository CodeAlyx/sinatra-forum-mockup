class CreatePostsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.integer :forum_id
    end
  end

  def down
    drop_table :posts
  end
end
