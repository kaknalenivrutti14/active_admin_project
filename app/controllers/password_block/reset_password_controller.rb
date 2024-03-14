module PasswordBlock	
	class ResetPasswordController < ApplicationController
		before_action :authenticate_user, only: [:verify_otp, :update_password]
	  def reset_password
			user_account = UserBlock::User.find_by(email: params[:email])

			if user_account
			  otp = UserBlock::EmailOtp.find_or_initialize_by(user_id: user_account.id)
			  otp.status =false
			  otp.save
			  token = JwtToken.encode_token(user_account.id)
			  render json: { message: 'OTP sent to your email address', token: token}, status: 200
			else
			  render json: { errors: 'Email is not register' }, status: 404
			end
		end		


		def verify_otp
			email_otp = @current_user&.email_otp

			if email_otp && email_otp.pin == params[:otp]
				
			  if email_otp.expire_at >= Time.now
			    email_otp.update_column("status",true)
			    render json: { message: "OTP verified successfully" }, status: 200
			  else
			    render json: { message: "The OTP has expired" }, status: 422
			  end
			else
			  render json: { message: "Invalid OTP" }, status: 401
			end
		end


		def change_password
		  return render json: { errors: "Email does not register" }, status: 404 if @current_user.nil?
			
			if @current_user&.email_otp&.status==true

			  if @current_user.update(password: params[:password])
			    render json: { message: "Password updated successfully." }, status: 200
			  else
			    render json: { errors: user.errors.full_messages }, status: 422
			  end
			else
			  render json: { message: "Please first verify the OTP with email" }, status: 422
			end

		end

		def update_password

			if @current_user.authenticate(params[:old_password])
				if @current_user.update(password: params[:new_password])
					render json: { message: "Password updated successfully"},status: 200
				else
					render json: { errors: @current_user.errors.full_messages }, status: 422
				end
			else
				render json: { errors: "Invalid password" }, status: 422
			end 	
		end

	end

end
