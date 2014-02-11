require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user" do
  	user = create :user, password: 'passw0rd'
  	assert user.encrypted_password
  	assert_nil user.password
  end

  test "access token craation" do
    user = build :user
    assert_nil user.access_token

    user.save
    assert user.access_token
  end
end
