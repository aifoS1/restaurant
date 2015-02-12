

# Make sure we load all the gems
require 'bundler'
Bundler.require :default
require 'securerandom'

# Then connect to the database
set :database, {
  adapter: "postgresql", database: "restaurant",
  host: "localhost", port: 5432
}

require_relative 'environment'
require './app'

map('/foods') { run FoodsController }
map('/parties') { run PartiesController }
map('/orders') { run OrdersController }
map('/employees') { run EmployeesController }
map('/') { run WelcomeController }
map('/') { run SimpleAuthController }


run Restaurant
run Sinatra::Application