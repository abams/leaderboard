require 'test_helper'

class AuthenticationTest < ApiTest

  test "login" do
    user = create :user, password: 'hammer'
    post "api/v1/login", username_or_email: user.email, password: 'hammerxxx'
    assert_equal 401, last_response.status

    post "api/v1/login", username_or_email: user.email, password: 'hammer'
    assert_equal 200, last_response.status

    assert_equal user.access_token, last_json['access_token']
  end

  test "signin" do
    existing_user = create :user
    post "api/v1/signup", username: existing_user.username, email: "abc#{existing_user.email}", password: '123456'
    assert_equal 401, last_response.status

    post "api/v1/signup", username: "newuser", email: 'newuser@gmail.com', password: 'saltandpeppa'
    assert_equal 200, last_response.status

    assert last_json['id']
    assert last_json['username']
    assert last_json['access_token']

  end
end
