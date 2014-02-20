class PagesController < ApplicationController
  skip_before_filter :require_user

  def home
    redirect_to leaderboard_path if current_user
    @games = Game.order(id: :desc).limit(5)
  end

  def profile
    @user = User.find_by(username: params[:username])
    render status: :not_found, action: :not_found and return unless @user

    @games = @user.games.last(5)
    @ranking = @user.rankings.last
  end
end
