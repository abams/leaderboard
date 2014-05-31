# Leaderboard

Leaderboard keeps track of your office ping pong matches (or other games) and ranks the players.  Leaderboard will post results to slack if configured.

## Installation

Deploy Leaderboard to Heroku

Provision a Postgres instance and a RedisToGo (free) instance

Set up an S3 bucket for avatars

Add a default avatar and upload it to:
```
"https://#{ENV['S3_ENDPOINT']}/#{BUCKET}/avatars/default/default_1.jpg"
```

If you are using slack, you can add a referee avatar:
```
"https://#{ENV['S3_ENDPOINT']}/pongpong/assets/slack_icon.jpg"
```


Or you can fork it, and change the configuration to your liking.


## Configuration

You'll need to set the following environment variables:

* OPENREDIS_URL
* S3_ENDPOINT
* S3_ACCESS_KEY
* S3_SECRET_KEY

If you want Leaderboard to post results to a slack channel you'll also need:

* SLACK_API_TOKEN
* [SLACK_WEBHOOK_URL](https://slack.com/signin?redir=%2Fservices%2Fnew%2Fincoming-webhook)
* SLACK_CHANNEL (optional)


## Contributing

1. Fork it ( http://github.com/<my-github-username>/flocks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
