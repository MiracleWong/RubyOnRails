class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  def index
    render json: User.all
  end
end
