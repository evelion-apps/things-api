require "graphql"
require_relative "types/task"

class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  # Fields

  field :headings, [TaskType], null: false do
    description "List headings"
  end

  field :projects, [TaskType], null: false do
    description "List projects"
  end

  field :todos, [TaskType], null: false do
    description "List to dos"
  end

  field :today, [TaskType], null: false do
    description "List today"
  end

  # Data Resolvers

  def todos
    Task.where(type: 0).where(status: 0)
  end

  def headings
    Task.where(type: 2).where(status: 0)
  end

  def projects
    Task.where(type: 1).where(status: 0)
  end

  def today
    today = DateTime.now.in_time_zone("GMT").beginning_of_day.strftime('%s').to_f

    Task.where(todayIndexReferenceDate: today)
  end
end
