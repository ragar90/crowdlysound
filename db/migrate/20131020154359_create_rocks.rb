class CreateRocks < ActiveRecord::Migration
  def change
    create_table :rocks do |t|
      t.references :musician, index: true
      t.integer :content_id
      t.string :content_type

      t.timestamps
    end
  end
end
