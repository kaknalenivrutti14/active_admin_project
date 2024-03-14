FactoryBot.define do
  factory :user_block_email_otp, class: 'UserBlock::EmailOtp' do
    pin { 1 }
    expire_at { "2024-02-26 16:40:37" }
    user { nil }
  end
end
