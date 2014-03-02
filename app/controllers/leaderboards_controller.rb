class LeaderboardsController < ApplicationController

	def index
		@rankings = Ranking.order(score: :desc)
	end
end
