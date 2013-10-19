class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.integer :leader_id

      t.timestamps
    end
  end
end
