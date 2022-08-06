module Types
  class MutationType < Types::BaseObject
    field :create_repository, mutation: Mutations::CreateRepository, null: false
    field :create_user, mutation: Mutations::CreateUser, null: false
  end
end
