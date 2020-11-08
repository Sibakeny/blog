require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

set :default_env, {
  'MYSQL_USER' => ENV['MYSQL_USER'],
  'MYSQL_PASSWORD' => ENV['MYSQL_PASSWORD'],
  'MYSQL_HOST' => ENV['MYSQL_HOST']
}