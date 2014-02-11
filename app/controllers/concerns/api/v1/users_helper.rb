module Api::V1::UsersHelper

  def access_token_string
    @_access_token_string ||= if !request.authorization.blank?
      # Bearer header
      /Bearer (.+)/.match(request.authorization).try(:[], 1)
    else
      # Query string
      params[:access_token]
    end
  end

  def current_user
    @current_user ||= begin
      if access_token_string
        User.find_or_create_by(access_token: access_token_string)
      end
    end
  end

  def require_user
    render_error :unauthorized, 'This method requires a user.' unless current_user
  end
end
