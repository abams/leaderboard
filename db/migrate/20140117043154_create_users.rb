class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :password, null: false
      t.string :encrypted_password
      t.string :salt
      t.string :avatar_file_name
      t.timestamps
    end
  end
end
