require './app/workers/slack_tournament_worker'

class TournamentsController < ApplicationController

  def show
    @tournament = Tournament.find_by_id(params[:id])

    @semi_left = @tournament.semi_finals.games.first(2)
    @semi_right = @tournament.semi_finals.games.last(2)
    @quarter_left = [@tournament.quarter_finals.games.first]
    @quarter_right = [@tournament.quarter_finals.games.last]
    @final = @tournament.finals.games.first
  end

  def new
    @users = User.all
  end

  def create
    @tournament = Tournament.create!
    @tournament.create_rounds

    @tournament.rounds.each do |round|
      round.create_games
    end

    ids_from_rankings = Ranking.current_month.where(user_id: params[:user_ids]).map(&:user_id)

    unranked_ids = params[:user_ids] - ids_from_rankings
    user_ids = (ids_from_rankings << unranked_ids).flatten

    @tournament.semi_finals.populate_games(user_ids)

    SlackTournamentWorker.new.perform(@tournament.id)
    redirect_to tournament_path(@tournament.id)
  end

  def update
    @tournament = Tournament.find_by_id(params[:id])

    case params[:round]
    when 'left_semi_1'
      @tournament.quarter_finals.games.first.update_attributes!(winner_id: params[:winner_id])
    when 'left_semi_2'
      @tournament.quarter_finals.games.first.update_attributes!(loser_id: params[:winner_id])
    when 'right_semi_1'
      @tournament.quarter_finals.games.last.update_attributes!(winner_id: params[:winner_id])
    when 'right_semi_2'
      @tournament.quarter_finals.games.last.update_attributes!(loser_id: params[:winner_id])
    when 'left_quarter_1'
      @tournament.finals.games.first.update_attributes!(winner_id: params[:winner_id])
    when 'right_quarter_1'
      @tournament.finals.games.first.update_attributes!(loser_id: params[:winner_id])
    when 'final'
      @tournament.winner_id = params[:winner_id]
      @tournament.save

      SlackTournamentWorker.new.perform(tournament.id)
    end

    redirect_to tournament_path(@tournament.id)
  end


end
