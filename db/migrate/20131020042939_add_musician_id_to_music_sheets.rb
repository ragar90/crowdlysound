class AddMusicianIdToMusicSheets < ActiveRecord::Migration
  def change
    add_column :music_sheets, :musician_id, :integer
  end
end
