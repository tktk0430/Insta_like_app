class AddColumnToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :comment_id, :integer
  end
end
