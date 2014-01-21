class LeaguesController < ApplicationController

	def new
		@league = League.new
	end

	def create
		league = current_user.leagues.create(league_params)
		redirect_to league_path(league)
	end

	def show
		@league = League.find_by(id: params[:id])
	end

	private

	def league_params
		params.require(:league).permit(:name)
	end
end
