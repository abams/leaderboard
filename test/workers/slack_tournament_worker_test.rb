require 'test_helper'

class SlackReportingWorkerTest < ActiveSupport::TestCase

  test "perform" do
    tournament = Tournament.new

    notifier = MiniTest::Mock.new
    notifier.expect(:deliver, true)

    SlackNotifier.expects(:new).with(kind_of(Hash)).returns(notifier)

    SlackTournamentWorker.perform_async(tournament.id)
    SlackReportingWorker.drain
  end
end
