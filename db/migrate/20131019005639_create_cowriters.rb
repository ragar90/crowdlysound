class CreateCowriters < ActiveRecord::Migration
  def change
    create_table :cowriters do |t|
      t.integer :musician_id
      t.integer :song_id

      t.timestamps
    end
  end
end
