class CreateInstrumentSkills < ActiveRecord::Migration
  def change
    create_table :instrument_skills do |t|
      t.integer :musician_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
