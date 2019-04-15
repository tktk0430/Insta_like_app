class ChageColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    change_column :notifications, :micropost_id, :integer, null: true
  end
end
