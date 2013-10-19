class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :owner_id
      t.string :owner_type
      t.integer :cover_of_id
      t.integer :rock_likes_count

      t.timestamps
    end
  end
end
