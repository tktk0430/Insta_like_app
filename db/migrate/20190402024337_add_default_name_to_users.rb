class AddDefaultNameToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, :default => "No name"
  end
end
