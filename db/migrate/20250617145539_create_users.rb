class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
t.string :email,              null: false, default: ""
t.string :encrypted_password, null: false, default: ""
      t.text :description, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.timestamps
    end
  end
end
