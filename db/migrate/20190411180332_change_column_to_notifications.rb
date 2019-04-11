class ChangeColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_index :notifications, [:visiter_id,:visited_id]
  end
end
