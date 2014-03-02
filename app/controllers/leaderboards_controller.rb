class LeaderboardsController < ApplicationController

	def index
		@rankings = Ranking.all
	end
end
