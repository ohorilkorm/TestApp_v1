require 'net/http'
class HomeController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @title = ''
    @userName = userParams['username']

    userResult = JSON.parse(Net::HTTP.get(URI.parse("https://api.github.com/users/#{userParams['username']}")))
    result = JSON.parse(Net::HTTP.get(URI.parse("https://api.github.com/users/#{userParams['username']}/repos")))

    if userResult['message'].nil?
      @title = ''
    else
      @title = userResult['message']
      return
    end

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

    variablesCreateUser = { "username": userParams['username'] }
    createUserResulte = JSON.parse(TestAppSchema.execute(createUser, variables: variablesCreateUser).to_json)
    userId = createUserResulte['data']['createUser']['user']['id']

    result.each do |res|
      createRepository = '
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

      variablesCreateRepository = { "name": res['name'], "userId": userId.to_i }
      TestAppSchema.execute(createRepository, variables: variablesCreateRepository).to_json
    end

    getUserInformation = '
    query getUserInformation($id: ID!){
      user(id:$id){
       username
        repositories{
         name
       }
          repositoriesCount
       }
    }'
    variablesCreateUser = { "id": userId }
    getUserInformationResult = JSON.parse(TestAppSchema.execute(getUserInformation,
                                                                variables: variablesCreateUser).to_json)
    # render plain: getUserInformationResult
    @repositories = []
    getUserInformationResult['data']['user']['repositories'].each do |r|
      @repositories << r['name']
    end
  end

  private

  def userParams
    params.require(:user).permit(:username)
  end
end
