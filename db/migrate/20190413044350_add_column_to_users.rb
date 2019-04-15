class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_data, :text
  end
end
