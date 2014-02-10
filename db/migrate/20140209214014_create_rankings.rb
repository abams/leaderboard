class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :user_id
      t.integer :month
      t.integer :score, default: 0, null: false
      t.integer :rank, unique: true
      t.timestamps
    end
  end
end
