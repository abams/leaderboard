require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_user
  	user = create :user, password: 'passw0rd'
  	assert user.encrypted_password
  	assert_nil user.password
  end
end
