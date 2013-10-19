class CreateGenreTags < ActiveRecord::Migration
  def change
    create_table :genre_tags do |t|
      t.integer :genre_id
      t.integer :song_id

      t.timestamps
    end
  end
end
