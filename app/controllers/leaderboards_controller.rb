class LeaderboardsController < ApplicationController

	def index
		users = User.all

		@data = users.inject({}) do |hsh, u|
			hsh[u.username.to_sym] = u.winning_matches.count * 3 + u.losing_matches.count
			hsh
		end

		@data.sort_by { |username, wins| wins }
	end

	def monthly

	end

	def weekly

	end

	def daily

	end
end
