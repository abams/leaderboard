class PagesController < ApplicationController
  skip_before_filter :require_user

  def home
    redirect_to leaderboard_path if current_user
    @games = Game.order(id: :desc).limit(5)
  end
end
