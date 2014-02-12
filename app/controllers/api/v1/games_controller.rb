class Api::V1::GamesController < Api::V1::BaseController

  def new
    render json: User.where('id != ?', current_user.id)
  end

  def create
    game = Game.create!(winner_id: current_user.id, loser_id: params[:opponent_id])
    SlackReportingWorker.perform_async(game.id)
    head :created
  end
end
