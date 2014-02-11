class Ranking < ActiveRecord::Base
  belongs_to :user

  scope :for_month, -> { where(month: Time.current.strftime('%Y%m')) }

  def self.default_serialization_options
    {
      only: [:score],
      include: { user: User.default_serialization_options }
    }
  end

  def update_score(opponent_score, result)
    diff = opponent_score - score
    weight = diff / 5

    bonus = if diff >= 0
      if result == :win
        10 + weight
      else
        -5 + [weight, 4].min
      end
    else
      if result == :win
        10 + [weight, -9].max
      else
        -5 + weight
      end
    end

    # Don't let a user's score fall below 0
    self.score = [(score + bonus), 0].max
    self.save
  end
end
