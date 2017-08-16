class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      #now that we have the user, we want to encrypt their userId
      token = issue_token(user_id: @user.id)
      render json: {jwt: token}
    else
      render json: {message: "Error bad password!"}
    end
  end


end
