module FollowBlock
  class Follower < ApplicationRecord
    self.table_name = :follow_block_followers
    belongs_to :follower, class_name: 'UserBlock::User', foreign_key: 'follower_id'
    belongs_to :following, class_name: 'UserBlock::User', foreign_key: 'following_id'

    def self.ransackable_associations(auth_object = nil)
      ["follower", "following"]
    end

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "follower_id", "following_id", "id", "updated_at"]
    end
    
  end
end
