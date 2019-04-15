class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :name
      t.text :introduction
      t.string :password_digest
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
