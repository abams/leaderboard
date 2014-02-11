class Api::V1::LeaderboardsController < Api::V1::BaseController

  def index
    rankings = Ranking.where(month: current_month).order(score: :desc)
    render json: rankings
  end

  protected

  def current_month
    @current_month ||= Time.current.strftime('%Y%m')
  end
end
