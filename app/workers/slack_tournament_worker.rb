class SlackTournamentWorker
  # include Sidekiq::Worker

  def perform(game_id)
    return unless @tournament = Tournament.find_by(id: game_id)
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
    if @tournament.winner_id
      "#{@tournament.winner.username} has won this weeks tournament!"
    else
      "This week's tournament has been posted, find your matchup.
      #{ENV['LEADERBOARD_URL']}/tournament/#{@tournament.id}"
    end
  end
end
