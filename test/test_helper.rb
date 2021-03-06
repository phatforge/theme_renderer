require 'coveralls'
Coveralls.wear!

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

# Configure Rails Environment
ENV['RAILS_ENV'] ||= 'test'
ENV['RUBY_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require 'minitest/autorun'
require 'capybara/rails'
require 'capybara_minitest_spec'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.
    expand_path('../fixtures', __FILE__)
end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type(/integration$/, self)
end

if Rails.configuration.database_configuration['test']['database'] == ':memory:'
  puts 'creating sqlite in memory database'
  load "#{Rails.root}/db/schema.rb"
end
