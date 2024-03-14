class UserBlock::UsersController < ApplicationController
   

  def sign_up
    user = UserBlock::User.new(user_params)

    if user.save
      token = JwtToken.encode_token(user.id)
      render json: { user: UserBlock::UserSerializer.new(user).serializable_hash, token: token, message: "User created successfully" }, status: :ok
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end


  def sign_in 
    email = params[:email]
    password = params[:password]
    user = UserBlock::User.find_by(email:email) if email.present?

    if user
      if user.authenticate(password)
        token = JwtToken.encode_token(user.id)
        render json: { user:UserBlock::UserSerializer.new(user).serializable_hash, token: token, message: "User login successfully" }, status: :ok

      else
        render json: { message: "Invalid password" }, status:401
      end
    else
      render json: {message: "Invalid email" }, status:404
    end
          
  end

  def country_code_with_flag
    data = {}
    Country.countries.each { |country| data[country.iso_short_name] = country.emoji_flag }

    render json: { message:"All country code with flag", data: data}, status:200
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
end
