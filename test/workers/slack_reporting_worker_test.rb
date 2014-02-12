require 'test_helper'

class SlackReportingWorkerTest < ActiveSupport::TestCase

  test "perform" do
    game = create :game

    notifier = MiniTest::Mock.new
    notifier.expect(:deliver, true)

    SlackNotifier.expects(:new).with(kind_of(Hash)).returns(notifier)

    SlackReportingWorker.perform_async(game.id)
    SlackReportingWorker.drain
  end
end
