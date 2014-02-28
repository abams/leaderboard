class AddRoundIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :round_id, :integer
    add_column :rounds, :tournament_id, :integer, null: false
  end
end
