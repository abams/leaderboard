class UsersController < ApplicationController

	def show
		@user = User.find_by(id: params[:id])
		@games = @user.games.last(5)
		@ranking = @user.rankings.last
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		user = User.find_by(id: params[:id])
		user.update_attributes! user_params
		redirect_to user_path user.id
	end

	private

	def user_params
		params.require(:user).permit(:avatar)
	end
end
