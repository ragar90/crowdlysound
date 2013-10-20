class AddIsGuestToMusicians < ActiveRecord::Migration
  def change
    add_column :musicians, :is_guest, :boolean, :default => false
  end
end
