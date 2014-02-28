class SlackReportingWorker
  # include Sidekiq::Worker

  def perform(game_id)
    return unless @game = Game.find_by(id: game_id)
    SlackNotifier.new(options).deliver
  end

  private

  def options
    {
      message: message,
      channel: 'pingpong-private'
    }
  end

  def message
    "#{@game.winner.username} defeated #{@game.loser.username}!
    #{@game.winner.username} now has #{@game.winner.rankings.last.score} points.
    #{ENV['LEADERBOARD_URL']}/leaderboard"
  end
end
