# frozen_string_literal: true

require 'spec_helper'
require 'database_cleaner'
require 'factory_bot'
require 'capybara/rspec'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
ActiveRecord::Migration.maintain_test_schema!
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  config.include AuthenticationHelper

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before(:each) do |example|
    if example.metadata[:type] == :system
      driven_by :selenium,
        using: :headless_chrome,
        screen_size: [1400, 1400]
    end
  end
end
