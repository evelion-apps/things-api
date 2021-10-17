require "graphql"
require_relative "types/task"

class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  field :tasks, [TaskType], null: false do
    description "List task"
  end

  def tasks
    Task.all
  end
end
