class UserBlock::EmailOtp < ApplicationRecord
  self.table_name = :user_block_email_otps

  belongs_to :user, class_name: 'UserBlock::User'
  before_save :set_pin_and_valid_time
  after_save :send_otp_on_mail
  validates :pin, presence: true
  validates :expire_at, presence: true

  private 

    def set_pin_and_valid_time
      self.pin = rand(1_00000..9_99999)
      self.expire_at = (Time.now + 5.minutes)
    end

    def send_otp_on_mail
      user = UserBlock::User.find(user_id)
      UserBlock::EmailOtpMailer.otp_email({email:user&.email, otp:self.pin}).deliver_now
    end

end
