require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest

	def test_signup
		username = 'test'
		post '/sessions/create', user: { username: username, email: 'valid@email.com', password: 'passw0rd' }
		assert_equal User.find_by(username: username).id, session[:user_id]
	end

	def test_email_login
		password = 'passw0rd'
		user = create :user, password: password
		post '/login', username_or_email: user.email, password: password
		assert_equal user.id, session[:user_id]
	end
end
