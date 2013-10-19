class CreateCastingSettings < ActiveRecord::Migration
  def change
    create_table :casting_settings do |t|
      t.integer :song_id
      t.integer :filter_type_id

      t.timestamps
    end
  end
end
