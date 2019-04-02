class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account, :string
    change_column :users, :account, :string, null: false
    add_column :users, :web, :string
    add_column :users, :tel, :integer
    add_column :users, :sex, :integer
    change_column :users, :sex, :integer, null: false, default: 2
  end
end
