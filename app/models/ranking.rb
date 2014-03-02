class Ranking < ActiveRecord::Base
  belongs_to :user

  # ELO rating constant
  K_FACTOR = 100

  def self.default_serialization_options
    {
      only: [:score],
      include: { user: User.default_serialization_options }
    }
  end

  # Based on ELO Rating
  def update_score(opponent_score, result)
    # Make it easier to rollback accidential game creation
    self.previous_score = score

    actual_score = (result == :win) ? 1 : 0
    expected_score = 1.0 / ( 1.0 + ( 10.0 ** ((opponent_score - score) / 400.0) ) )

    self.score = [((score + (K_FACTOR * (actual_score - expected_score)))), 100].max
    self.save
  end
end
