class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :message
      t.integer :author_id
      t.string :comentable_id
      t.string :comentable_type

      t.timestamps
    end
  end
end
