require 'net/http'
class HomeController < ApplicationController
  def new
    @user = User.new
  end
  def create

    @title = ""
    @userName = user_params["username"]

    userResult = JSON.parse(Net::HTTP.get(URI.parse("https://api.github.com/users/#{user_params['username']}")))
    result = JSON.parse(Net::HTTP.get(URI.parse("https://api.github.com/users/#{user_params['username']}/repos")))

    if userResult["message"].nil?
    else
      @title = userResult["message"]
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

    variablesCreateUser = {"username": user_params["username"]}
    createUserResulte = JSON.parse(TestAppSchema.execute(createUser, variables: variablesCreateUser).to_json)
    userId = createUserResulte["data"]["createUser"]["user"]["id"]

    result.each { |res|
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

      variablesCreateRepository = {"name": res["name"], "userId": userId.to_i}
      TestAppSchema.execute(createRepository, variables: variablesCreateRepository).to_json
    }

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
    variablesCreateUser = {"id": userId}
    getUserInformationResult = JSON.parse(TestAppSchema.execute(getUserInformation, variables: variablesCreateUser).to_json)
    #render plain: getUserInformationResult
    @repositories = Array.new
    getUserInformationResult["data"]["user"]["repositories"].each { |r|
      @repositories << r['name']
    }

  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
