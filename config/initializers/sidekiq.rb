require 'redis'

redis_uri = ENV['OPENREDIS_URL'] || ENV['REDISTOGO_URL'] || 'redis://localhost:6379'

Sidekiq.configure_client do |config|
  config.redis = { url: redis_uri } if redis_uri
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_uri } if redis_uri
end
