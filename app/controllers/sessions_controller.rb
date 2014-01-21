class SessionsController < ApplicationController

	skip_before_action :require_user, only: [:new, :create, :login, :login_attempt]

	def login
	end

	def login_attempt
    authorized_user = User.authenticate(username_or_email: params[:username_or_email], login_password: params[:password])

    if authorized_user
    	session[:user_id] = authorized_user.id
      redirect_to matches_path
    else
      flash[:notice] = "Invalid Username or Password"
      redirect_to login_path
    end
  end

	def new
	end

	def create
		# raise "#{params}"
		user = User.find_or_initialize_by(email: params[:email])

		if user.persisted?
			flash[:notice] = "A user with this email already exists"
			redirect_to sessions_new_path
		else
			user.update_attributes! user_params
			session[:user_id] = user.id
			redirect_to matches_path
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
		params.permit(:username, :email, :password, :password_confirmation)
	end

end
