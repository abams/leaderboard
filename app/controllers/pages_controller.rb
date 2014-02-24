class PagesController < ApplicationController
  skip_before_filter :require_user

  def home
    redirect_to leaderboard_path if current_user
    @games = Game.order(id: :desc).limit(5)
  end

  def profile
    @user = if params[:username] == 'me'
      User.find_by(id: current_user.id)
    else
      User.find_by(username: params[:username])
    end

    render status: :not_found, action: :not_found and return unless @user

    @games = @user.recent_games
    @ranking = @user.rankings.last
  end
end
