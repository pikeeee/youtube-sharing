class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.integer :user_id, null: false
      t.string :url
      t.string :title

      t.timestamps
    end

    add_index :videos, :user_id
  end
end