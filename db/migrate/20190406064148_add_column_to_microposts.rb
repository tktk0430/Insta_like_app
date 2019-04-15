class AddColumnToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :image_data, :text
  end
end
