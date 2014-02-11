require 'test_helper'

class SlackNotifierTest < ActiveSupport::TestCase

  test "deliver" do
    ENV['SLACK_WEBHOOK_URL'] = 'http://url.com'
    ENV['SLACK_API_TOKEN'] = '1234'

    stub_request(:post, "http://url.com/?token=1234").
      with(:body => "{\"text\":\"hello\",\"channel\":\"#general\",\"icon_url\":\"https:///pongpong/assets/slack_icon.jpg\",\"username\":\"Referee\"}",
           :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.8.9'}).
      to_return(:status => 200, :body => "", :headers => {})


    options = {
      message: 'hello',
      channel: 'general',
      gif_query: 'celebrate'
    }

    SlackNotifier.new(options).deliver
  end
end
