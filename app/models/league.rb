class League < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :matches

	before_save :generate_slug

	private

  def generate_slug
    begin
      self.slug = SecureRandom.base64(6) unless self.slug
    end while self.class.exists?(slug: self.slug)
  end

end
