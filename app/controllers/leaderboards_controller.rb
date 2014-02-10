class LeaderboardsController < ApplicationController

	def index
		@rankings = Ranking.for_month.order(score: :desc)
	end
end
