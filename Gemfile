# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'mysql2'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

# API関連
gem 'active_model_serializers'
gem 'rack-cors'

# マークダウン関連
gem 'coderay'
gem 'redcarpet'

# .env
gem 'dotenv-rails'

# i18n enum
gem 'enum_help'
gem 'rails-i18n'

# ページング
gem 'kaminari'
gem 'kaminari-bootstrap'

# チャート
gem 'chartkick'

# パンくず
gem 'breadcrumbs_on_rails'

# Qiita API
gem 'qiita-sdk', '~> 1.1.1'

gem 'reverse_markdown'

# 初期データ
gem 'seed-fu'

gem 'listen', '>= 3.0.5', '< 3.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'rubocop'
  gem 'selenium-webdriver'

  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
end

group :development do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
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
