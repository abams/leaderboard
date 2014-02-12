class LeaderboardsController < ApplicationController

	def index
		@rankings = Ranking.for_current_month
	end
end
