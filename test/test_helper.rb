ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rubygems'
require 'sidekiq/testing'
require 'webmock/minitest'
require 'minitest/autorun'
require 'mocha/setup'

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
end

class ActionDispatch::IntegrationTest
  include RackMacros
end

class ApiTest < ActionDispatch::IntegrationTest
  include Rack::Test::Methods
end
