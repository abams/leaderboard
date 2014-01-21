class Match < ActiveRecord::Base
	has_many :users, through: :league
	belongs_to :league

	serialize :score
end
