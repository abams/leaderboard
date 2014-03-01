class LeaderboardsController < ApplicationController

	def index
		@rankings = Ranking.current_month

    if @rankings.empty?
      @rankings = Ranking.where(month: 1.month.ago.strftime('%Y%m')).order(score: :desc)
    end
	end
end
