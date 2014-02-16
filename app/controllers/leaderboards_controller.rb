class LeaderboardsController < ApplicationController

	def index
		@rankings = Ranking.current_month
	end
end
