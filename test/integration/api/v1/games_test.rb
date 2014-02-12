require 'test_helper'

class GamesTest < ApiTest

  test "new" do
    user = create :user
    current_user = create :user
    get "api/v1/games/new"
    assert_equal 401, last_response.status

    header 'Authorization', "Bearer #{current_user.access_token}"
    get "api/v1/games/new"
    assert_equal 200, last_response.status
    assert_equal 1, last_json.size
    assert_equal user.id, last_json.first['id']
  end

  test "create" do
    winner = create :user
    loser = create :user

    post "api/v1/games"
    assert_equal 401, last_response.status

    SlackReportingWorker.expects(:perform_async).once

    header 'Authorization', "Bearer #{winner.access_token}"
    post "api/v1/games", opponent_id: loser.id
    assert_equal 201, last_response.status

    assert_equal winner.id, Game.last.winner_id
    assert_equal loser.id, Game.last.loser_id
  end
end
