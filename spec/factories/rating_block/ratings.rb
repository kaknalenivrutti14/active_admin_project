FactoryBot.define do
  factory :rating_block_rating, class: 'RatingBlock::Rating' do
    value { 1 }
    user { nil }
    property { nil }
  end
end
