class Api::V1::UsersController  < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = user.new(username: params[:username], password: params[:password])
    if @user.save
      render json: @user
    else
      render json: {message: "Error user not created!"}
    end
  end

  def show

  end

  def update

  end

  def destroy

  end


end
