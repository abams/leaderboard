require 'test_helper'

class MatchesTest < ActiveSupport::TestCase

	def test_associations
		user = create :user
		league = create :league
		user.leagues << league

		match = create :match, league_id: league.id

		assert_equal match.id, user.matches.first.id
		assert_equal user.id, match.users.first.id
		assert_equal league.id, user.leagues.first.id
		assert_equal user.id, league.users.first.id
	end
end
