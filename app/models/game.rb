class Game < ActiveRecord::Base
  belongs_to :loser, class_name: 'User', foreign_key: :loser_id
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id
  belongs_to :round

	validate :cannot_play_self

  after_save :update_player_rankings

  serialize :score

  scope :regular_season, -> { where(round_id: nil) }

  private

  def cannot_play_self
    return if winner_id == 0 && loser_id == 0
    errors.add(:base, 'You cannot play yourself.') if winner_id == loser_id
  end

  def update_player_rankings
    # Don't update palyer rankings if game is part of a tournament
    return if round.present?

    winner_rank = winner.rankings.find_or_initialize_by(month: current_month)
    loser_rank = loser.rankings.find_or_initialize_by(month: current_month)

    if !winner_rank.persisted?
      winner_rank.score = winner.rankings.where(month: previous_month).first.try(:score) || 1000
      winner_rank.save
    end

    if !loser_rank.persisted?
      loser_rank.score = loser.rankings.where(month: previous_month).first.try(:score) || 1000
      loser_rank.save
    end

    winner_rank.update_score(loser_rank.score, :win)
    loser_rank.update_score(winner_rank.score, :loss)
  end

  def previous_month
    @previous_month ||= 1.month.ago.strftime('%Y%m')
  end

  def current_month
    @current_month ||= Time.current.strftime('%Y%m')
  end
end
