class Ranking < ActiveRecord::Base
  belongs_to :user

  # ELO rating constant
  K_FACTOR = 32

  scope :current_month, -> { where(month: Time.current.strftime('%Y%m')).order(score: :desc) }

  def self.default_serialization_options
    {
      only: [:score],
      include: { user: User.default_serialization_options }
    }
  end

  # Based on ELO Rating
  def update_score(opponent_score, result)
    actual_score = (result == :win) ? 1 : 0
    expected_score = 1.0 / ( 1.0 + ( 10.0 ** ((opponent_score - score) / 400.0) ) )

    self.score = [((score + (K_FACTOR * (actual_score - expected_score)))), 100].max
    self.save
  end
end
