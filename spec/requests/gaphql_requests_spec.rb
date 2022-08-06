
require 'rails_helper'
require 'rspec/rails'
require 'net/http'

RSpec.describe 'Test graphql ' do
  it 'User creation is valid with userId is not nil' do
    createUser = '
    mutation CreateUser ($username: String!){
      createUser( input:{username: $username}) {
        user{
          id
          username
        }
          errors
        }
    }'

    variablesCreateUser = {"username": 'test'}
    createUserResulte = JSON.parse(TestAppSchema.execute(createUser, variables: variablesCreateUser).to_json)
    userId = createUserResulte["data"]["createUser"]["user"]["id"]

    expect(userId.nil?).to eq false
  end

  it 'Repo creation is valid with empty errors field' do

    user = User.new(username: "username")

    createRepository='
      mutation CreateRepository($name: String!, $userId: Int!){
      createRepository( input:{name: $name, userId: $userId}) {
        repository{
          id
          userId
          name
        }
         errors
        }
      }'

    variablesCreateRepository = {"name": 'test', "userId": user.id}
    requestRes = TestAppSchema.execute(createRepository, variables: variablesCreateRepository).to_json

    res = requestRes["errors"]["message"]

    expect(res.nil?).to eq true
  end

end

