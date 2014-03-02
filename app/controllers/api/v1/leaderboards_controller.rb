class Api::V1::LeaderboardsController < Api::V1::BaseController

  def index
    rankings = Ranking.order(score: :desc)
    render json: rankings
  end
end
