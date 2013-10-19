class CreateCastings < ActiveRecord::Migration
  def change
    create_table :castings do |t|
      t.integer :caster_id
      t.integer :casting_song_id
      t.integer :status, default: 3

      t.timestamps
    end
  end
end
