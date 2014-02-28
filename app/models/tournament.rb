class Tournament < ActiveRecord::Base
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id

  has_many :rounds, dependent: :destroy

  def semi_finals
    rounds.where(name: 'semi-finals').first
  end

  def quarter_finals
    rounds.where(name: 'quarter-finals').first
  end

  def finals
    rounds.where(name: 'finals').first
  end

  def create_rounds
    rounds.create!(name: 'semi-finals')
    rounds.create!(name: 'quarter-finals')
    rounds.create!(name: 'finals')
  end
end
