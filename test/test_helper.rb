ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rubygems'
require 'sidekiq/testing'
require 'webmock/minitest'
require 'minitest/autorun'
require 'mocha/setup'

# Stub s3 requests
AWS.stub!

Sidekiq.configure_server do |config|
  Sidekiq.logger = nil
end

# Support files
Dir[Rails.root.join('test/support/**/*.rb')].each do |file|
  require file
end

FactoryGirl.find_definitions

class ActiveSupport::TestCase
	# syntactically simple, create, build, etc
  include FactoryGirl::Syntax::Methods

  ActiveRecord::Migration.check_pending!

  def setup
    # Stub AWS, not sure why AWS.stub! is not working
    stub_request(:get, /.*pongpong\/avatars\/.*/).to_return(body: "{}")
  end
end

class ActionDispatch::IntegrationTest
  include RackMacros
end

class ApiTest < ActionDispatch::IntegrationTest
  include Rack::Test::Methods
end
