class User < ActiveRecord::Base
	has_and_belongs_to_many :leagues
	has_many :matches, through: :leagues

  EMAIL_REGEX = /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates :username, presence: true, uniqueness: true, length: { :in => 3..20 }
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, confirmation: true
  validates_length_of :password, in: 6..20, on: :create

  before_save :encrypt_password
	after_save :clear_password


	def self.authenticate(options = {})
	  user = if EMAIL_REGEX.match options[:username_or_email]
	    User.find_by(email: options[:username_or_email])
	  else
	    User.find_by(username: options[:username_or_email])
	  end

	  user if user && user.match_password(options[:login_password])
	end

	def match_password(login_password="")
	  encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
	end

	private

	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def clear_password
	  self.password = nil
	end
end
