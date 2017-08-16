class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorized

  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: "Not authorized"}, status: 404 unless logged_in?
  end

  def current_user
    authenticate_or_request_with_http_token do |token, options|
      user_id = decoded_token(token)[0]["user_id"]
      user = User.find(user_id)
      @current_user ||= user
    end
  end

  def issue_token(payload)
    JWT.encode(payload, "learnlovecode")
  end

  def decoded_token(token)
    begin
      JWT.decode(token, "learnlovecode")
    rescue JWT::DecodeError
      return nil
    end
  end


end
