class AddSaltToMusicians < ActiveRecord::Migration
  def change
    add_column :musicians, :salt, :string
  end
end
