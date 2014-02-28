class GamesController < ApplicationController

	def index
		@games = Game.regular_season.order(id: :desc).limit(5)
	end

	def new
		@users = User.all
	end

	def create
		game = Game.create!(winner_id: current_user.id, loser_id: params[:opponent_id])

		# Change to async whe worker dyno spun up on heroku
    SlackReportingWorker.new.perform(game.id)
		redirect_to leaderboard_path
	end
end
