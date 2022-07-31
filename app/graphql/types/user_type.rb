# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String
    field :repositories, [Types::RepositoryType], null: false
    field :repositoriesCount, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def repositoriesCount
      object.repositories.size
    end
  end
end
