class ApplicationController < ActionController::Base
 require 'jwt_token'
  skip_forgery_protection
  
  # Authentication
  def authenticate_user
      token = request.headers['token']
      if token
        decoded_token = JwtToken.decode_token(token)
        if decoded_token
          @current_user = UserBlock::User.find_by(id: decoded_token[0]['user_id'])
           render json: { message: 'User not found' }, status: :not_found unless @current_user
           return @current_user if @current_user
        else
          render json: { message: 'Token expired' }, status: :unauthorized
        end
      else
        render json: { message: 'Token not found' }, status: :unauthorized
      end

  rescue => e
    render json: { errors: e.message, message:"Invalid token" },status: 401
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render json: { error: 'Record not found' }, status: 404
  end

end
