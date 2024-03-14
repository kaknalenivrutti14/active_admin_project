class FollowerBlock::FollowerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :follower_id, :following_id
end
