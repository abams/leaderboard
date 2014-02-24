require 'test_helper'

class RankingTest < ActiveSupport::TestCase

  test "elo rating" do
    good_rank = create :ranking, score: 2000
    bad_rank = create :ranking, score: 1000

    good_rank.update_score bad_rank.score, :win
    assert_equal 2000, good_rank.score

    good_rank.score = 2000
    good_rank.save

    good_rank.update_score bad_rank.score, :loss
    assert_equal 1900, good_rank.score

    bad_rank.update_score good_rank.score, :loss
    assert_equal 999, bad_rank.score

    good_rank.score = 2000
    good_rank.save
    bad_rank.score = 1000
    bad_rank.save

    bad_rank.update_score good_rank.score, :win
    assert_equal 1099, bad_rank.score
  end
end
