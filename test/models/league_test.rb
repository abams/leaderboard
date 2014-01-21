require 'test_helper'

class LeagueTest < ActiveSupport::TestCase

  def test_user_association
  	user = create :user
  	# league = create :league, user: user
  	assert user.leagues.empty?

  	league = create :league
  	assert league.users.empty?
  end

  def test_slug_creation
  	league = create :league
  	assert league.slug
  end
end
