class AddPreviousScoreToRankings < ActiveRecord::Migration
  def up
    add_column :rankings, :previous_score, :integer, default: 1000, null: false
    remove_column :rankings, :month
    change_column_default :rankings, :score, 1000

  end

  def down
    remove_column :rankings, :previous_score
    add_column :rankings, :month, :integer
    change_column_default :rankings, :score, 0
  end

end
