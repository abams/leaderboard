class LeaderboardsController < ApplicationController

	def index
		@rankings = Ranking.for_current_month.order(score: :desc)
	end
end
