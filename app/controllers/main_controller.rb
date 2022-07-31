require 'net/http'
class MainController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    render plain: @user
  end

  private

  def user_params
    params.require(:user).permit(:username, :reposlink)
  end

end
