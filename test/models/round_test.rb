require 'test_helper'

class RoundTest < ActiveSupport::TestCase

  test "populate rounds" do
    users = []
    7.times {
      user = create :user
      users << user
    }

    user_ids = users.map(&:id)
    tournament = Tournament.create
    round = tournament.rounds.create(name: 'semi-finals')

    round.populate_games(user_ids)
    assert_equal 4, round.games.size

    # Test byes
    assert_equal 0, round.games.first.loser_id
  end
end
