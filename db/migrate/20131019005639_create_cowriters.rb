class CreateCowriters < ActiveRecord::Migration
  def change
    create_table :cowriters do |t|
      t.integer :coauthor_id
      t.integer :coauthored_song_id
      t.integer :casting_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
