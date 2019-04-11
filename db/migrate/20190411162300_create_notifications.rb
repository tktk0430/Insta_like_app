class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id, presence: true
      t.integer :micropost_id
      t.integer :visited_id, presence: true
      t.string :controller
      t.boolean :checked, presence: true, default: false

      t.timestamps
    end
    add_index :notifications, :visiter_id
    add_index :notifications, :visited_id
    add_index :notifications, [:visiter_id,:visited_id], unique: true
  end
end
