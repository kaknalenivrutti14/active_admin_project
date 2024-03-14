FactoryBot.define do
  factory :follow_block_follower, class: 'FollowBlock::Follower' do
    follower_id { 1 }
    following_id { 1 }
  end
end
