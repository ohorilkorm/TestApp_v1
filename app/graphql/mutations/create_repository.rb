class Mutations::CreateRepository < Mutations::BaseMutation

  argument :name, String
  argument :userId, Integer
  field :repository, Types::RepositoryType
  field :errors, [String], null: false

  def resolve(name:,userId:)
    repository = Repository.new(name: name, user_id: userId)
    if repository.save
      {
        repository: repository,
        errors: []
      }
    else
      {
        repository: nil,
        errors: user.errors.full_messages
      }
    end
  end
end