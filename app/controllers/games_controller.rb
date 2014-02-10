class GamesController < ApplicationController

	def index
		@games = Game.order(id: :desc).limit(5)
	end

	def new
		@users = User.all
	end

	def create
		Game.create!(winner_id: current_user.id, loser_id: params[:opponent_id])
		redirect_to leaderboard_path
	end
end
