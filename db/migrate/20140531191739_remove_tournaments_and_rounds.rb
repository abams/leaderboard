class RemoveTournamentsAndRounds < ActiveRecord::Migration
  def up
    drop_table :rounds
    drop_table :tournaments
    remove_column :games, :round_id
  end

  def down
    create_table :tournaments do |t|
      t.timestamps
    end

    create_table :rounds do |t|
      t.integer :tournament_id, null: false
      t.timestamps
    end

    add_column :games, :round_id, :integer
  end
end
