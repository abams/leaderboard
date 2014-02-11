require 'test_helper'

class LeaderboardTest < ApiTest

  test "index" do
    ranking = create :ranking
    user = ranking.user

    get "api/v1/leaderboard"
    assert_equal 401, last_response.status

    header 'Authorization', "Bearer #{user.access_token}"
    get "api/v1/leaderboard"
    assert_equal 200, last_response.status

    assert_equal ranking.score, last_json.first['score']
    assert_equal ranking.user.id, last_json.first['user']['id']
  end
end
