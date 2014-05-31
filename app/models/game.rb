class Game < ActiveRecord::Base
  belongs_to :loser, class_name: 'User', foreign_key: :loser_id
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id

	validate :cannot_play_self

  after_save :update_player_rankings

  serialize :score

  private

  def cannot_play_self
    return if winner_id == 0 && loser_id == 0
    errors.add(:base, 'You cannot play yourself.') if winner_id == loser_id
  end

  def update_player_rankings
    winner_score = winner.ranking.score
    loser_score = loser.ranking.score

    winner.ranking.update_score(loser_score, :win)
    loser.ranking.update_score(winner_score, :loss)
  end
end
