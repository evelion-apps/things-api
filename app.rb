require "sinatra"
require "sinatra/activerecord"
require "sinatra/json"
require "sinatra/reloader" if development?

require_relative "models/task"
require_relative "graphql/schema"

# Active Record

configure do
  unless ENV["DB"].present?
    p "Error: path to database file is missing. Please specify `bin/start 3000 db/dev.sqlite3`"
    exit 1
  end

  set :database, {adapter: "sqlite3", pool: 5, timeout: 60000, database: ENV["DB"]}
end

# Sinatra

class ThingsApi < Sinatra::Base
  get "/" do
    "Welcome to GraphQL API for Things 3!\n\nTo get started, send a POST request to `/` with a valid GraphQL request in the body."
  end

  post "/" do
    request.body.rewind

    params = JSON.parse(request.body.read)

    result = ThingsApiGraphQLSchema.execute(
      params["query"],
      variables: params["variables"],
      context: { current_user: nil }
    )

    json result
  end
end
