require 'test_helper'

class RankingTest < ActiveSupport::TestCase

  test "udpate score" do
    good_rank = create :ranking, score: 100
    bad_rank = create :ranking, score: 10

    good_rank.update_score bad_rank.score, :win
    assert_equal 101, good_rank.score

    good_rank.score = 100
    good_rank.save

    good_rank.update_score bad_rank.score, :loss
    assert_equal 77, good_rank.score

    bad_rank.update_score good_rank.score, :loss
    assert_equal 9, bad_rank.score

    good_rank.score = 100
    good_rank.save
    bad_rank.score = 10
    bad_rank.save

    bad_rank.update_score good_rank.score, :win
    assert_equal 38, bad_rank.score
  end
end
