class UserBlock::EmailOtpMailer < ApplicationMailer

	def otp_email(otp_data)
		@data = otp_data
      mail(
          to: @data[:email],
          from: "nitish.kumar@extwebtech.in",
          subject: 'Password Reset Request')
    end
end
