class CreateFollowBands < ActiveRecord::Migration
  def change
    create_table :follow_bands do |t|
      t.references :band, index: true
      t.references :musician, index: true

      t.timestamps
    end
  end
end
