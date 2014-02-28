class AddNameToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :name, :string
    add_column :tournaments, :winner_id, :integer
  end
end
