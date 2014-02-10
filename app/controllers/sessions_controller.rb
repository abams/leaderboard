class SessionsController < ApplicationController

	skip_before_action :require_user, only: [:new, :create, :login, :login_attempt]

	def login
	end

	def login_attempt
    authorized_user = User.authenticate(username_or_email: params[:username_or_email], login_password: params[:password])

    if authorized_user
    	session[:user_id] = authorized_user.id
      redirect_to leaderboard_path
    else
      flash[:notice] = "Invalid Username or Password"
      redirect_to login_path
    end
  end

	def new
		@user = User.new
	end

	def create
		user = User.find_or_initialize_by(email: params[:user][:email])

		if user.persisted?
			flash[:notice] = "A user with this email already exists"
			redirect_to sessions_new_path
		else
      begin
  			user.update_attributes! user_params
      rescue => e
        flash[:notice] = "#{e}".gsub('Validation failed:', '')
        redirect_to signup_path and return
      end

			session[:user_id] = user.id
			redirect_to leaderboard_path user.id
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end

	def failure
		flash[:error] = params[:message]
		redirect_to new_session_path
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
	end

end
