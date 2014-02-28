class Round < ActiveRecord::Base
  has_many :games

  def populate_games(user_ids)
    create_games if games.empty?

    if user_ids.size < 8
      user_ids << 'bye' until user_ids.size == 8
    end

    game = games[0]
    game.winner_id = user_ids[0]
    game.loser_id = user_ids[7]
    game.save!

    game = games[1]
    game.winner_id = user_ids[2]
    game.loser_id = user_ids[5]
    game.save!

    game = games[2]
    game.winner_id = user_ids[1]
    game.loser_id = user_ids[6]
    game.save!

    game = games[3]
    game.winner_id = user_ids[3]
    game.loser_id = user_ids[4]
    game.save!
  end

  def create_games
    number = case name
    when 'semi-finals' then 4
    when 'quarter-finals' then 2
    when 'finals' then 1
    end

    number.times { games.create!(winner_id: 0, loser_id: 0) }
  end
end
