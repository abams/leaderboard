class UsersController < ApplicationController

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		user = User.find_by(id: params[:id])
		user.update_attributes! user_params
		redirect_to profile_path user.username
	end

	private

	def user_params
		params.require(:user).permit(:avatar)
	end
end
