require 'faraday'

class SlackNotifier

  def initialize(options)
    @options = options
  end

  def deliver
    return unless ENV['SLACK_API_TOKEN'] && @options[:message] && @options[:channel]
    Faraday.post slack_url, body, headers
  end

  private

  def headers
    @options[:headers] || { 'Content-Type' => 'application/json' }
  end

  def body
    {
      text: "#{@options[:message]}",
      channel: "##{@options[:channel]}".sub('##', '#'),
      icon_url: @options[:icon_url] || "https://#{ENV['S3_ENDPOINT']}/pongpong/assets/slack_icon.jpg",
      username: @options[:username] || 'Referee',
    }.to_json
  end

  def slack_url
    "#{ENV['SLACK_WEBHOOK_URL']}?token=#{ENV['SLACK_API_TOKEN']}"
  end
end
