class Api::V1::AuthenticationController < Api::V1::BaseController

  skip_before_filter :require_user

  def signup
    user = User.where('email = ? OR username = ?', params[:email], params[:username]).first

    if user
      render_error :unauthorized, "Email or Username already exists"
    else
      render json: User.create!(user_params).as_personal_json
    end

  end

  def login
    user = User.authenticate(authentication_params)

    if user
      render json: user.as_personal_json
    else
      render_error :unauthorized, "Invalid Password"
    end
  end

  protected

  def authentication_params
    {
      username_or_email: params[:username_or_email],
      login_password: params[:password]
    }
  end

  def user_params
    params.permit(:email, :username, :password)
  end
end
