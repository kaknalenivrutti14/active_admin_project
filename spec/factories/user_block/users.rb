FactoryBot.define do
  factory :user_block_user, class: 'UserBlock::User' do
    name {"nitish"}
    email {"nitish@gmail.com"}
    password {"123456"}
  end
end
