# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'jbuilder', '~> 2.7'
gem 'mysql2'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

gem 'bcrypt', '~> 3.1.7'

gem 'active_model_serializers'

gem 'jquery-ui-rails'

gem 'coderay'
gem 'redcarpet'

gem 'rack-cors'

gem 'dotenv-rails'

gem 'rails-i18n'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'kaminari'
gem 'kaminari-bootstrap'

gem 'chartkick'

gem 'breadcrumbs_on_rails'

gem 'enum_help'

gem 'qiita-sdk', '~> 0.3.0'
gem 'reverse_markdown'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'rubocop'
  gem 'selenium-webdriver'
end

group :development do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'unicorn'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
