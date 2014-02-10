require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "validations" do
    game = Game.create(winner_id: 1, loser_id: 1)
    assert game.errors
  end

  test "win/loss creation" do
    game = create :game
    assert_equal 1, game.winner.wins.count
    assert_equal 1, game.loser.losses.count
  end

  test "update player rankings" do
    game = create :game

    assert_equal 10, game.winner.rankings.last.score
    assert_equal 0, game.loser.rankings.last.score
  end
end
