class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
    add_index :microposts, [:user_id,:created_at]
  end
end
