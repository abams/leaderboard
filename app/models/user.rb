class User < ActiveRecord::Base
	has_many :wins, foreign_key: :winner_id
	has_many :losses, foreign_key: :loser_id
	has_many :rankings

  EMAIL_REGEX = /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates :username, presence: true, uniqueness: true, length: { :in => 3..20 }
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, confirmation: true
  validates_length_of :password, in: 6..20, on: :create

  before_save :encrypt_password, :set_access_token
	after_save :clear_password

	BUCKET = 'pongpong'
	DEFAULT_AVATAR_URL = "https://#{ENV['S3_ENDPOINT']}/#{BUCKET}/avatars/default/default_1.jpg"

	has_attached_file :avatar,
		bucket: BUCKET,
		storage: :s3,
    url: ":s3_domain_url",
	  path: "avatars/#{Rails.env}/:id/:style/:basename.:extension",
		styles: {
			medium: "300x300#",
			thumb: "100x100#"
		},
    :default_url => "https://#{ENV['S3_ENDPOINT']}/#{BUCKET}/avatars/default/default_:style.jpg"

	def self.default_serialization_options
    {
      only: [:id, :username],
      methods: [:avatar_url]
    }
  end

  def self.personal_serialization_options
  	{
      only: [:id, :username, :access_token],
      methods: [:avatar_url]
    }
  end

  def as_personal_json(options = {})
    self.as_json(self.class.personal_serialization_options)
  end

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

	def current_rank
		rankings.where(month: Time.current.strftime('%Y%m')).first
	end

	def avatar_url
		avatar.url(:medium)
	end

	private

	def set_access_token
    return unless access_token.blank?
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: self.access_token)
  end

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
