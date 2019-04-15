class RenameColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :controller, :action
  end
end
