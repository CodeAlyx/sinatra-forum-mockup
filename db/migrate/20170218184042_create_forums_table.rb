class CreateForumsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :forums do |t|
      t.string :title
      t.text :topic
      t.integer :user_id
    end
  end

  def down
    drop_table :forums
  end
end
