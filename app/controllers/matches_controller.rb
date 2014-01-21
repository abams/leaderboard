class MatchesController < ApplicationController

	def index
		@matches = WinningMatch.order(id: :desc)
	end

	def new
		@users = User.all
	end

	def create
		LosingMatch.create!(user_id: params[:opponent_id], opponent_name: current_user.username, opponent_id: current_user.id)
		WinningMatch.create!(user_id: current_user.id, opponent_name: params[:opponent_name], opponent_id: params[:opponent_id])
		redirect_to matches_path
	end
end
