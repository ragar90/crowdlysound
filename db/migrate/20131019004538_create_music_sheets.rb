class CreateMusicSheets < ActiveRecord::Migration
  def change
    create_table :music_sheets do |t|
      t.text :notes
      t.integer :song_id
      t.integer :instrument_id
      t.integer :rock_likes_count
      
      t.timestamps
    end
  end
end
