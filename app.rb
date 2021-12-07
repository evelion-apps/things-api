require "sinatra"
require "sinatra/activerecord"
require "sinatra/json"
require "sinatra/reloader" if development?
require "dotenv/load"

require_relative "models/area"
require_relative "models/task"
require_relative "graphql/schema"

# Active Record

configure do
  unless ENV["DB"].present?
    p "Error: path to database file is missing. Please specify in the files `.env` or `.env.local` or pass as an argument in the start script `bin/start 3000 db/dev.sqlite3`"
    exit 1
  end

  set :database, {adapter: "sqlite3", pool: 5, timeout: 60000, database: ENV["DB"]}
end

# Periodic Jobs

if ENV["SYNC_DB_ENABLED"].downcase == "true"
  Thread.new do
    while true
      puts "[Periodic Job][Sync DB][#{Time.now}] Started"

      seconds_opt = ENV["SYNC_DB_REMOTE_WAIT_FOR_SYNC_IN_SECONDS"].present? ? "-s #{ENV["SYNC_DB_REMOTE_WAIT_FOR_SYNC_IN_SECONDS"]}" : nil
      remote_host_opt = ENV["SYNC_DB_REMOTE_HOST"].present? ? "-h #{ENV["SYNC_DB_REMOTE_HOST"]}" : nil
      user_opt = ENV["SYNC_DB_USERNAME"].present? ? "-u #{ENV["SYNC_DB_USERNAME"]}" : nil

      `scripts/sync-db.sh #{remote_host_opt} #{user_opt} #{seconds_opt}`

      puts "[Periodic Job][Sync DB][#{Time.now}] Completed"
      puts "[Periodic Job][Sync DB][#{Time.now}] Sleeping #{ENV["SYNC_DB_FREQUENCY_IN_SECONDS"]} seconds"

      sleep ENV["SYNC_DB_FREQUENCY_IN_SECONDS"].to_i
    end
  end
end

# Sinatra

class ThingsApi < Sinatra::Base
  get "/" do
    headers 'Access-Control-Allow-Origin' => '*'

    "Welcome to GraphQL API for Things 3!\n\nTo get started, send a POST request to `/` with a valid GraphQL request in the body."
  end

  post "/" do
    headers 'Access-Control-Allow-Origin' => '*'

    request.body.rewind

    request_body = request.body.read

    unless request_body.present?
      return json({error: "Invalid request. GraphQL query in the request body is missing."})
    end

    params = JSON.parse(request_body)

    result = ThingsApiGraphQLSchema.execute(
      params["query"],
      variables: params["variables"],
      context: { current_user: nil }
    )

    json result
  end
end
