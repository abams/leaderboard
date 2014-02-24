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
end
