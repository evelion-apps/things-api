require "graphql"

class TaskType < GraphQL::Schema::Object
  description "GraphQL Task Type"

  field :uuid, String, null: false
end
