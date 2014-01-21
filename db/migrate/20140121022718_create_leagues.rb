class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
    	t.string :name, null: false
      t.string :slug, unique: :true
      t.timestamps
    end
  end

  create_table :leagues_users do |t|
  	t.belongs_to :user
  	t.belongs_to :league
  end
end
