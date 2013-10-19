class CreateMusicTastes < ActiveRecord::Migration
  def change
    create_table :music_tastes do |t|
      t.integer :musician_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
