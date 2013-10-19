class CreateAgrupations < ActiveRecord::Migration
  def change
    create_table :agrupations do |t|
      t.integer :musician_id
      t.integer :band_id

      t.timestamps
    end
  end
end
