AWS.config({
	s3_endpoint: ENV['S3_ENDPOINT'] || 'development',
  access_key_id: ENV['S3_ACCESS_KEY'] || 'dev',
  secret_access_key: ENV['S3_SECRET_KEY'] || 'dev'
})
