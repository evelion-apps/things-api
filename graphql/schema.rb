require "graphql"
require_relative "mutation"
require_relative "query"

class ThingsApiGraphQLSchema < GraphQL::Schema
  mutation MutationType
  query QueryType
end
