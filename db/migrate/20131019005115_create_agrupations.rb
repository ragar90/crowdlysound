class CreateAgrupations < ActiveRecord::Migration
  def change
    create_table :agrupations do |t|
      t.integer :member_id
      t.integer :band_id
      t.boolean :is_leader

      t.timestamps
    end
  end
end
