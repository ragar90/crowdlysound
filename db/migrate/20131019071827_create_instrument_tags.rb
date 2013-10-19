class CreateInstrumentTags < ActiveRecord::Migration
  def change
    create_table :instrument_tags do |t|
      t.integer :instrument_id
      t.integer :song_id
      t.boolean :writen_by_me

      t.timestamps
    end
  end
end
