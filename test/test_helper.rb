ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rubygems'

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
