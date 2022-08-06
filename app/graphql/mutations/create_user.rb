class Mutations::CreateUser < Mutations::BaseMutation

    argument :username, String

    field :user, Types::UserType
    field :errors, [String], null: false

    def resolve(username:)
      user = User.new(username: username)
      if user.save
        {
         user: user,
         errors: []
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
      }
      end
    end
end